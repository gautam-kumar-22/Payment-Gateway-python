"""Register Subscription app models here."""
from django.contrib import admin
from .models import SubscriptionPlan, CustomerPlan


admin.site.register(SubscriptionPlan)
admin.site.register(CustomerPlan)
