"""Payments View."""
import datetime
from decimal import Decimal
from django.shortcuts import render, redirect
from django.conf import settings
import stripe
from django.urls import reverse
from django.views.generic.edit import UpdateView
from django.http import HttpResponseRedirect
from django.views.generic.base import TemplateView
from payments.models import SubscriptionPlan, CustomerPlan, BILLING_TYPES, PAYMENT_TYPES
from authentication.services import (
    payment_success_email, change_credit_card_email,
    cancel_subscription_email, change_subscription_email, change_billing_email)
from django.conf import settings
from django.views.generic import View
from authentication.views import BaseLoginRequired
from django.contrib import messages
from authentication.models import Customer
from django.contrib.auth import logout
from .forms import CustomerPlanForm
from .utils import RefundOrder


stripe.api_key = settings.STRIPE_SECRET_KEY


class HomePageView(BaseLoginRequired, TemplateView):
    """View to bookig payment."""

    template_name = 'home.html'

    def get(self, request, *args, **kwargs):
        """Dashboard info."""
        context = {}
        context['payment_types'] = PAYMENT_TYPES
        context['billing_cycles'] = BILLING_TYPES
        try:
            context['plan_obj'] = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
        except CustomerPlan.DoesNotExist:
            pass
        context['plan_obj'] = SubscriptionPlan.objects.get(pk=kwargs.get("pk"))
        context['key'] = settings.STRIPE_PUBLISHABLE_KEY
        context['paypal_key'] = settings.PAYPAL_CLIEND_ID
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        payment_type = request.POST.get("payment_types")
        if request.POST.get("amount"):
            plan_obj = SubscriptionPlan.objects.get(id=kwargs.get("pk"))
            billing_cycles = request.POST.get('billing_cycles')
            valid_from = datetime.date.today()
            billing_type = billing_cycles
            if billing_cycles == "monthly":
                valid_to = valid_from - datetime.timedelta(days=-30)
                total_amount = plan_obj.price
            elif billing_cycles == "yearly":
                valid_to = valid_from - datetime.timedelta(days=-365)
                total_amount = plan_obj.price * 12.0
            amount = int(float(total_amount))
            if payment_type == "paypal":
                CustomerPlan.objects.create(
                    customer=request.user, price=plan_obj.price,
                    plans=plan_obj, paypal_id=request.POST.get("capture_id"),
                    billing_type=billing_type, valid_from=valid_from,
                    valid_to=valid_to, is_paid=True, is_active=True,
                    payment_type=request.POST.get("payment_types"),
                    amount=total_amount)
            elif payment_type == "stripe":
                try:
                    customer_user = Customer.objects.get(customer=request.user)
                except Customer.DoesNotExist:
                    customer_user = Customer.objects.create(customer=request.user)
                if customer_user and customer_user.stripe_customer_id:
                    customer = stripe.Customer.retrieve(customer_user.stripe_customer_id)
                else:
                    customer = stripe.Customer.create(
                        source=request.POST.get("stripeToken"),
                        email=request.user.email,)
                    customer_user.stripe_customer_id = customer.id
                    customer_user.save()
                # Charge the Customer instead of the card:
                charge = stripe.Charge.create(
                    amount=amount, currency=settings.STRIPE_CURRENCY, customer=customer.id,)
                if charge.outcome.seller_message == 'Payment complete.' or charge.paid:
                    pass
                # payment_success_email(request.user, plan_obj)
                messages.success(request, "You have successfully created subscription.")
                CustomerPlan.objects.create(
                    customer=request.user, price=plan_obj.price,
                    plans=plan_obj, charge_id=charge.id,
                    billing_type=billing_type, valid_from=valid_from,
                    valid_to=valid_to, is_paid=True, is_active=True,
                    payment_type=request.POST.get("payment_types"),
                    amount=total_amount)
        return HttpResponseRedirect(reverse('authentication:dashboard'))


class ChangeCreditCardView(BaseLoginRequired, View):
    """Change credit card View."""

    model = CustomerPlan
    template_name = "change-credit-card.html"

    def get(self, request, *args, **kwargs):
        context = {}
        context['key'] = settings.STRIPE_PUBLISHABLE_KEY
        try:
            context['plan_obj'] = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
        except CustomerPlan.DoesNotExist:
            pass
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        if request.user.customer_user.stripe_customer_id:
            customer = stripe.Customer.retrieve(request.user.customer_user.stripe_customer_id)
        else:
            customer = stripe.Customer.create(
                source=request.POST.get("stripeToken"),
                email=request.user.email,)
            customer_obj = Customer.objects.create(
                customer=request.user, stripe_customer_id=customer.id)
        card = stripe.Customer.modify(customer.id, source=request.POST.get("stripeToken"),)
        print(card)
        # change_credit_card_email(request.user)
        messages.success(request, "You have successfully changed the credit card info.")
        return HttpResponseRedirect(reverse('authentication:dashboard'))


class ChangePaymentMethodView(BaseLoginRequired, View):
    """Change payment method View."""

    model = CustomerPlan
    template_name = "change-payment-method.html"

    def get(self, request, *args, **kwargs):
        context = {}
        context['key'] = settings.STRIPE_PUBLISHABLE_KEY
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            context['plan_obj'] = plan_obj
        except CustomerPlan.DoesNotExist:
            pass
        payment_method = None
        if plan_obj.payment_type == "stripe":
            payment_method = "paypal"
        elif plan_obj.payment_type == "paypal":
            payment_method = "stripe"
        context['payment_method'] = payment_method
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
        except CustomerPlan.DoesNotExist:
            pass
        CustomerPlan.objects.create(
            customer=plan_obj.customer,
            plans=plan_obj.plans,
            billing_type=plan_obj.billing_type,
            payment_type=request.POST.get("payment_method"),
            price=plan_obj.price,
            valid_from=plan_obj.valid_from,
            valid_to=plan_obj.valid_to,
            is_active=plan_obj.is_active,
            )
        plan_obj.delete()
        # change_payment_method_email(request.user)
        messages.success(request, "You have successfully changed the payment method.")
        return HttpResponseRedirect(reverse('authentication:dashboard'))


def get_cancel_subscription_price(plan_obj):
    ctx = {}
    current_date = datetime.date.today()
    billing_type = plan_obj.billing_type
    if billing_type == "monthly":
        used_days = current_date - plan_obj.valid_from
        remaing_days = 30 - used_days.days
        one_day_price = (plan_obj.price / 30)
    elif billing_type == "yearly":
        used_days = current_date - plan_obj.valid_from
        remaing_days = 365 - used_days.days
        one_day_price = ((plan_obj.price * 12) / 365)
    ctx['refundable_amount'] = remaing_days * one_day_price
    return ctx


class CancelSubscriptionView(BaseLoginRequired, View):
    """Cancel subscription View."""

    model = CustomerPlan
    template_name = "cancel-subscription.html"

    def get(self, request, *args, **kwargs):
        context = {}
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            ctx = get_cancel_subscription_price(plan_obj)
            context['plan_obj'] = plan_obj
            context['refundable_amount'] = ctx['refundable_amount']
        except CustomerPlan.DoesNotExist:
            pass
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            refundable_amount = self.request.POST.get('refundable_amount')
            if refundable_amount:
                plan_type = plan_obj.payment_type
                if plan_type == "paypal":
                    paypal_id = plan_obj.paypal_id
                    if paypal_id:
                        # RefundOrder().refund_order(paypal_id, amount=refundable_amount, debug=True)
                        print("paypal refunded")
                    plan_obj.amount = refundable_amount
                elif plan_type == "stripe":
                    amount = int(float(refundable_amount))
                    refund = stripe.Refund.create(
                        charge=plan_obj.charge_id,
                        amount=amount,)
                    if refund.status == "succeeded":
                        plan_obj.refund_id = refund.id
                        plan_obj.amount = refundable_amount
            plan_obj.is_cancel = True
            plan_obj.is_active = False
            plan_obj.save()
            # cancel_subscription_email(request.user, plan_obj)
            messages.success(self.request, "You have successfully cancelled the subscription.")
            # logout(request)
        except CustomerPlan.DoesNotExist:
            pass
        return HttpResponseRedirect(reverse('authentication:dashboard'))


def get_plan_price(plan_obj):
        ctx = {}
        valid_from = datetime.date.today()
        billing_type = plan_obj.billing_type
        if billing_type == "monthly":
            billing_type_amount = Decimal(1.0)
        elif billing_type == "yearly":
            billing_type_amount = Decimal(12.0)
        try:
            obj = SubscriptionPlan.objects.get(plan_type="basic")
            ctx['basic_price']  = obj.price * billing_type_amount
        except SubscriptionPlan.DoesNotExist:
            ctx['basic_price'] = Decimal(0.0)
        try:
            obj = SubscriptionPlan.objects.get(plan_type="premium")
            ctx['premium_price']  = obj.price * billing_type_amount
        except SubscriptionPlan.DoesNotExist:
            ctx['premium_price'] = Decimal(0.0)
        return ctx


class ChangePlanView(BaseLoginRequired, View):
    """Choose plan View."""

    model = CustomerPlan
    template_name = "choose-plan.html"

    def get(self, request, *args, **kwargs):
        context = {}
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            context['paypal_key'] = settings.PAYPAL_CLIEND_ID
            if plan_obj.plans.plan_type == "basic":
                context['change_plan'] = "premium"
                ctx = get_plan_price(plan_obj)
                context['payable_amount'] = ctx['premium_price'] - ctx['basic_price']
                if plan_obj.payment_type == "paypal":
                    context['paypal_payment'] = True
            elif plan_obj.plans.plan_type == "premium":
                context['change_plan'] = "basic"
                ctx = get_plan_price(plan_obj)
                context['refundable_amount'] = ctx['premium_price'] - ctx['basic_price']
            context['plan_obj'] = plan_obj
        except CustomerPlan.DoesNotExist:
            pass
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        try:
            plan_obj = SubscriptionPlan.objects.get(plan_type=self.request.POST.get('change_plan'))
            try:
                user_plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
                refundable_amount = self.request.POST.get('refundable_amount')
                payable_amount = self.request.POST.get('payable_amount')
                plan_type = user_plan_obj.payment_type
                if plan_type == "paypal":
                    if refundable_amount:
                        paypal_id = user_plan_obj.paypal_id
                        if paypal_id:
                            # RefundOrder().refund_order(paypal_id, amount=refundable_amount, debug=True)
                            print("paypal refunded")
                        plan_obj.amount = refundable_amount
                    elif payable_amount:
                        user_plan_obj.paypal_id = request.POST.get("capture_id")
                        plan_obj.amount = payable_amount
                elif plan_type == "stripe":
                    if refundable_amount:
                        amount = int(float(refundable_amount))
                        refund = stripe.Refund.create(
                            charge=user_plan_obj.charge_id,
                            amount=amount,)
                        if refund.status == "succeeded":
                            user_plan_obj.refund_id = refund.id
                            plan_obj.amount = refundable_amount
                    elif payable_amount:
                        amount = int(float(payable_amount))
                        if request.user.customer_user.stripe_customer_id:
                            customer = stripe.Customer.retrieve(
                                request.user.customer_user.stripe_customer_id)
                            charge = stripe.Charge.create(
                                amount=amount, currency=settings.STRIPE_CURRENCY, customer=customer.id,)
                            if charge.outcome.seller_message == 'Payment complete.' or charge.paid:
                                user_plan_obj.charge_id = charge.id
                                plan_obj.amount = payable_amount
                user_plan_obj.plans = plan_obj
                user_plan_obj.price = plan_obj.price
                user_plan_obj.save()
                # change_subscription_email(request.user, user_plan_obj)
                messages.success(self.request, "You have successfully change the subscription.")
            except CustomerPlan.DoesNotExist:
                pass
        except SubscriptionPlan.DoesNotExist:
            pass
        return HttpResponseRedirect(reverse('authentication:dashboard'))


def get_billing_price(plan_obj):
        ctx = {}
        current_date = datetime.date.today()
        billing_type = plan_obj.billing_type
        if billing_type == "monthly":
            converted_to = "yearly"
            used_days = current_date - plan_obj.valid_from
            remaining_days = 30 - used_days.days
            one_day_price = (plan_obj.price / 30)
            total_days = (365 - remaining_days )
            ctx['payable_amount'] = total_days * one_day_price
        elif billing_type == "yearly":
            converted_to = "monthly"
            used_days = current_date - plan_obj.valid_from
            total_days = used_days.days + 30
            one_day_price = ((plan_obj.price * 12) / 365)
            remaining_days = (365 - total_days)
            ctx['refundable_amount'] = remaining_days * one_day_price
        return ctx


class ChangeBillingCycleView(BaseLoginRequired, View):
    """Change billing cycle View."""

    model = CustomerPlan
    template_name = "change-billing.html"

    def get(self, request, *args, **kwargs):
        context = {}
        context['billing_cycles'] = BILLING_TYPES
        try:
            plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            context['paypal_key'] = settings.PAYPAL_CLIEND_ID
            if plan_obj.billing_type == "monthly":
                context['change_cycle'] = "yearly"
                ctx = get_billing_price(plan_obj)
                context['payable_amount'] = ctx['payable_amount']
            elif plan_obj.billing_type == "yearly":
                context['change_cycle'] = "monthly"
                ctx = get_billing_price(plan_obj)
                context['refundable_amount'] = ctx['refundable_amount']
            context['plan_obj'] = plan_obj
        except CustomerPlan.DoesNotExist:
            pass
        return render(request, self.template_name, context=context)

    def post(self, request, *args, **kwargs):
        billing_cycles = request.POST.get('change_cycle')
        valid_from = datetime.date.today()
        if billing_cycles == "monthly":
            valid_to = valid_from - datetime.timedelta(days=-30)
        elif billing_cycles == "yearly":
            valid_to = valid_from - datetime.timedelta(days=-365)
        try:
            user_plan_obj = request.user.customer_subscriptions.get(id=kwargs.get("pk"))
            refundable_amount = self.request.POST.get('refundable_amount')
            payable_amount = self.request.POST.get('payable_amount')
            plan_type = user_plan_obj.payment_type
            if plan_type == "paypal":
                if refundable_amount:
                    paypal_id = user_plan_obj.paypal_id
                    if paypal_id:
                        # RefundOrder().refund_order(paypal_id, amount=refundable_amount, debug=True)
                        print("paypal refunded")
                    plan_obj.amount = refundable_amount
                elif payable_amount:
                    user_plan_obj.paypal_id = request.POST.get("capture_id")
                    plan_obj.amount = payable_amount
            elif plan_type == "stripe":
                if refundable_amount:
                    amount = int(float(refundable_amount))
                    refund = stripe.Refund.create(
                        charge=user_plan_obj.charge_id,
                        amount=amount,)
                    if refund.status == "succeeded":
                        user_plan_obj.refund_id = refund.id
                        user_plan_obj.amount = refundable_amount
                elif payable_amount:
                    amount = int(float(payable_amount))
                    if request.user.customer_user.stripe_customer_id:
                        customer = stripe.Customer.retrieve(
                            request.user.customer_user.stripe_customer_id)
                        charge = stripe.Charge.create(
                            amount=amount, currency=settings.STRIPE_CURRENCY, customer=customer.id,)
                        if charge.outcome.seller_message == 'Payment complete.' or charge.paid:
                            user_plan_obj.charge_id = charge.id
                            user_plan_obj.amount = payable_amount
            user_plan_obj.billing_type = billing_cycles
            user_plan_obj.valid_from = valid_from
            user_plan_obj.valid_to = valid_to
            user_plan_obj.save()
            # change_billing_email(request.user, plan_obj)
            messages.success(self.request, "You have successfully change the subscription billing cycle.")
        except CustomerPlan.DoesNotExist:
            pass
        return HttpResponseRedirect(reverse('authentication:dashboard'))
