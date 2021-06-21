"""Subscription form."""
from django import forms
from .models import CustomerPlan


class CustomerPlanForm(forms.ModelForm):
    """Form for CustomerPlan edition."""

    class Meta:
        """Meta Class."""

        model = CustomerPlan
        fields = '__all__'
