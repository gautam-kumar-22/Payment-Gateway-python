from django.conf.urls import url

from . import views

app_name = 'payments'
urlpatterns = [
    url(r'^home/(?P<pk>[0-9]+)/$', views.HomePageView.as_view(), name='home'),
    url(r'^change-credit-card/(?P<pk>[0-9]+)/$', views.ChangeCreditCardView.as_view(), name='change-credit-card'),
    url(r'^change-payment-method/(?P<pk>[0-9]+)/$', views.ChangePaymentMethodView.as_view(), name='change-payment-method'),
    url(r'^cancel-subscription/(?P<pk>[0-9]+)/$', views.CancelSubscriptionView.as_view(), name='cancel-subscription'),
    url(r'^choose-plan/(?P<pk>[0-9]+)/$', views.ChangePlanView.as_view(), name='choose-plan'),
    url(r'^change-billing-cycle/(?P<pk>[0-9]+)/$', views.ChangeBillingCycleView.as_view(), name='change-billing-cycle'),
]
