import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/otp_screen.dart';

import 'home_screen.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Auth"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(hintText: "Mobile Number"),
          ),
          ElevatedButton(
              onPressed: () {
                sendOTP();
              },
              child: Text("Mobile Auth"))
        ],
      ),
    );
  }

  sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + textEditingController.text,
        verificationCompleted: (PhoneAuthCredential credentails) async {
          await FirebaseAuth.instance.signInWithCredential(credentails);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false);
        },
        verificationFailed: (FirebaseAuthException exception) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("exception: " + exception.toString())));
        },
        codeSent: (String verificationID, int resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OTPScreen(verificationID, resendToken)));
        },
        codeAutoRetrievalTimeout: (String timeOut) {});
  }
}
