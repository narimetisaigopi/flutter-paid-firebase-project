import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: editingController,
            decoration: InputDecoration(hintText: "Enter Amount"),
          ),
          ElevatedButton(
              onPressed: () {
                startPayment();
              },
              child: Text("Recharge"))
        ],
      ),
    );
  }

  startPayment() {
    var _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_WC6D7YRBLtqmkC',
      'amount': int.parse(editingController.text) * 100,
      'name': 'My It Solution',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // payment screen start here
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // our DB insertion

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("_handlePaymentSuccess : " + response.orderId),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("_handlePaymentError : " + response.message),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("_handleExternalWallet : " + response.walletName),
    ));
  }
}
