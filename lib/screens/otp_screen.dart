import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/home_screen.dart';

class OTPScreen extends StatefulWidget {
  String verficationID;
  int resendToken;
  OTPScreen(this.verficationID, this.resendToken);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: editingController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(hintText: "Enter OTP"),
          ),
          ElevatedButton(
              onPressed: () async {
                await verifyOTP();
              },
              child: Text("Verifiy OTP"))
        ],
      ),
    );
  }

  verifyOTP() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verficationID, smsCode: editingController.text);

    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("onError: " + onError.toString())));
    });
  }
}
