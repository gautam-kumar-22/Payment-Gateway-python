"""Extra functionality."""
from django.template.loader import render_to_string
# from django.conf import settings
from django.core.mail import EmailMessage


def payment_success_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Payment Successful'
    message = render_to_string('email/payment_success_email.html', {
        'user': user,
        'plan': plan,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()


def cancel_subscription_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Cancel Subscription'
    message = render_to_string('email/cancel_subscription_email.html', {
        'user': user,
        'plan': plan,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()


def change_subscription_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Change Subscription'
    message = render_to_string('email/change_subscription_email.html', {
        'user': user,
        'plan': plan,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()


def change_billing_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Change Billing Type'
    message = render_to_string('email/change_billing_email.html', {
        'user': user,
        'plan': plan,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()

def change_credit_card_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Change Credit Card Info.'
    message = render_to_string('email/change_credit_card_email.html', {
        'user': user,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()

def change_payment_method_email(user, plan):
    """Sending email to user."""
    mail_subject = 'Change Payment Method.'
    message = render_to_string('email/change_payment_method_email.html', {
        'user': user,
    })
    to_email = user.email
    email = EmailMessage(mail_subject, message, to=["admin@mailinator.com"])
    email.content_subtype = "html"
    return email.send()
