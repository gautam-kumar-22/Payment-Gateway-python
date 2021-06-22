# Create your views here.

import stripe

from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.contrib.auth.models import User
from django.views.generic import View, ListView
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.contrib import messages
from django.template import RequestContext
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.conf import settings
from .models import Customer
from .services import payment_success_email
from payments.models import SubscriptionPlan, CustomerPlan, BILLING_TYPES, PAYMENT_TYPES

stripe.api_key = settings.STRIPE_SECRET_KEY

@method_decorator(lambda x: login_required(x, login_url=reverse_lazy('authentication:login')), name='dispatch')
class BaseLoginRequired(LoginRequiredMixin, SuccessMessageMixin, View):
    """Check user is login or not."""
    pass


class DashboardView(BaseLoginRequired, View):
    """Dashboard view."""
    template_name = 'welcome.html'

    def get(self, request):
        """Dashboard info."""
        context = {}
        context['subscriptionplans'] = SubscriptionPlan.objects.all()
        context['key'] = settings.STRIPE_PUBLISHABLE_KEY
        try:
            context['active_plan'] = request.user.customer_subscriptions.get(is_active=True)
        except CustomerPlan.DoesNotExist:
            pass
        return render(request, self.template_name, context=context)


class LoginView(View):
    """Login view."""

    login_template_name = 'login.html'

    def get(self, request):
        """If user will be already login then redirect to welcome page else redirect to login page."""
        if request.user.is_authenticated:
            return HttpResponseRedirect(reverse('authentication:dashboard'))
        else:
            return render(request, self.login_template_name, {})

    def post(self, request, *args, **kwargs):
        """Login user and redirect them to related template as per the condition."""
        username = request.POST.get('username', None)
        password = request.POST.get('password', None)
        user = authenticate(username=username, password=password)
        if user:
            login(request, user)
            return HttpResponseRedirect(reverse('authentication:dashboard'))
        else:
            messages.error(request, 'Incorrect Username or Password ')
        return HttpResponseRedirect(reverse('authentication:login'))


class LogoutView(View):
    """Logout to user."""

    template_name = 'login.html'

    def get(self, request, *args, **kwargs):
        """Logout to user."""
        logout(request)
        return redirect('authentication:login')
