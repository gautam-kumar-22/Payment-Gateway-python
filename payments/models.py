"""Model structure of authentication."""
from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import (
    AbstractBaseUser, BaseUserManager, PermissionsMixin)

from authentication.models import TimeStampedModel


PLAN_TYPES = (
    ('basic', "Basic"),
    ('premium', "Premium"),
)

BILLING_TYPES = (
    ('monthly', "Monthly"),
    ('yearly', "Yearly"),
)

PAYMENT_TYPES = (
    ('stripe', "Stripe"),
    ('paypal', "Paypal"),
)


class SubscriptionPlan(TimeStampedModel):
    """SubscriptionPlan model."""

    plan_type = models.CharField(
        choices=PLAN_TYPES, max_length=50, null=True, blank=True)
    price = models.DecimalField(
        max_digits=10, decimal_places=2, null=True, blank=True)

    def __str__(self):
        """Object representation."""
        return self.plan_type


class CustomerPlan(TimeStampedModel):
    """Customer Plan model."""

    customer = models.ForeignKey(
        User, on_delete=models.CASCADE, null=True, blank=True, related_name="customer_subscriptions")
    plans = models.ForeignKey(
        SubscriptionPlan, null=True, blank=True, related_name='subscriptions')
    billing_type = models.CharField(
        choices=BILLING_TYPES, max_length=50, null=True, blank=True)
    payment_type = models.CharField(
        choices=PAYMENT_TYPES, max_length=50, null=True, blank=True)
    price = models.DecimalField(
        max_digits=10, decimal_places=2, null=True, blank=True)
    valid_from = models.DateField(null=True, blank=True)
    valid_to = models.DateField(null=True, blank=True)
    is_active = models.BooleanField(default=False)
    is_paid = models.BooleanField(default=False)
    is_refund = models.BooleanField(default=False)
    is_cancel = models.BooleanField(default=False)
    charge_id = models.CharField(max_length=255, null=True, blank=True)
    refund_id = models.CharField(max_length=255, null=True, blank=True)
    paypal_id = models.CharField(max_length=255, null=True, blank=True)
    amount = models.DecimalField(
        max_digits=10, decimal_places=2, null=True, blank=True)


    def __str__(self):
        """Str method to return object."""
        return self.customer.username + self.plans.plan_type
