from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User


class TimeStampedModel(models.Model):
    """TimeStampedModel.

    An abstract base class model that provides self-managed "created" and
    "updated" fields.
    """

    created_on = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_on = models.DateTimeField(auto_now=True, null=True, blank=True)

    class Meta:
        """Extra setting."""

        get_latest_by = 'modified_on'
        ordering = ('-created_on',)
        abstract = True


class Customer(TimeStampedModel):
    """Customer model."""

    customer = models.OneToOneField(
    	User, on_delete=models.CASCADE, related_name="customer_user")
    stripe_customer_id = models.CharField(max_length=255, null=True, blank=True)


    def __str__(self):
        """Str method to return object."""
        return self.stripe_customer_id
