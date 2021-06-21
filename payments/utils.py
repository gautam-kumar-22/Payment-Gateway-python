# 1. Import the PayPal SDK client that was created in `Set up Server-Side SDK`.
from paypalcheckoutsdk.payments import CapturesRefundRequest
from paypalcheckoutsdk.core import PayPalHttpClient, SandboxEnvironment
from paypalcheckoutsdk.payments import CapturesRefundRequest
from django.conf import settings
import json

import sys


class PayPalClient:
    def __init__(self):
        self.client_id = settings.PAYPAL_CLIEND_ID
        self.client_secret = settings.PAYPAL_SECRET_ID

        """Set up and return PayPal Python SDK environment with PayPal access credentials.
           This sample uses SandboxEnvironment. In production, use LiveEnvironment."""

        self.environment = SandboxEnvironment(client_id=self.client_id, client_secret=self.client_secret)

        """ Returns PayPal HTTP client instance with environment that has access
            credentials context. Use this instance to invoke PayPal APIs, provided the
            credentials have access. """
        self.client = PayPalHttpClient(self.environment)

    def object_to_json(self, json_data):
        """
        Function to print all json data in an organized readable manner
        """
        result = {}
        if sys.version_info[0] < 3:
            itr = json_data.__dict__.iteritems()
        else:
            itr = json_data.__dict__.items()
        for key,value in itr:
            # Skip internal attributes.
            if key.startswith("__"):
                continue
            result[key] = self.array_to_json_array(value) if isinstance(value, list) else\
                        self.object_to_json(value) if not self.is_primittive(value) else\
                         value
        return result;
    def array_to_json_array(self, json_array):
        result =[]
        if isinstance(json_array, list):
            for item in json_array:
                result.append(self.object_to_json(item) if  not self.is_primittive(item) \
                              else self.array_to_json_array(item) if isinstance(item, list) else item)
        return result;

    def is_primittive(self, data):
        return isinstance(data, str) or isinstance(data, unicode) or isinstance(data, int)


class RefundOrder(PayPalClient):

  #2. Set up your server to receive a call from the client
  """Use the following function to refund an capture.
     Pass a valid capture ID as an argument."""
  def refund_order(self, capture_id, amount=None, debug=False):
    request = CapturesRefundRequest(capture_id)
    request.prefer("return=representation")
    request.request_body(self.build_request_body(amount=amount))
    #3. Call PayPal to refund an capture
    response = self.client.execute(request)
    if debug:
      print 'Status Code:', response.status_code
      print 'Status:', response.result.status
      print 'Order ID:', response.result.id
      print 'Links:'
      for link in response.result.links:
        print('\t{}: {}\tCall Type: {}'.format(link.rel, link.href, link.method))
      json_data = self.object_to_json(response.result)
      print "json_data: ", json.dumps(json_data,indent=4)    
    return response

  """Request body for building a partial refund request.
     For full refund, pass the empty body.
     For more details, refer to the Payments API refund captured payment reference."""
  @staticmethod
  def build_request_body(amount=None):
    return \
      {
        "amount": {
          "value": amount,
          "currency_code": "USD"
        }
      }
