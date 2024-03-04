import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authenticaiton_flutter/home_screen.dart';
import 'package:phone_authenticaiton_flutter/otp_screen.dart';

class Otpmethods {
  static Future<dynamic> phoneAuthentication(
      String phoneNumber, dynamic context, bool first) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verficationid, int? resenttoken) {
          // _isloading = false;
          if (first == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPScreen(
                          verificationid: verficationid,
                          phonenumber: phoneNumber.trim(),
                        )));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPScreen(
                          verificationid: verficationid,
                          phonenumber: phoneNumber.trim(),
                        )));
            print(">>>>>>>>>>>>>>resend");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: "+91${phoneNumber.trim()}");
  }

  static Future<dynamic> executeFinal(
      {required String verificationid,
      required dynamic context,
      required String firstotp,
      required String secondotp,
      required String thirdotp,
      required String forthotp,
      required String fifthotp,
      required String sixthotp}) async {
    try {
      PhoneAuthCredential credential =
          // await PhoneAuthProvider.credential(
          //     verificationId: widget.verificationid,
          //     smsCode: otpController.text.trim().toString());
          await PhoneAuthProvider.credential(
              verificationId: verificationid,
              smsCode: firstotp.trim().toString() +
                  secondotp.trim().toString() +
                  thirdotp.trim().toString() +
                  forthotp.trim().toString() +
                  fifthotp.trim().toString() +
                  sixthotp.trim().toString());
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } catch (ex) {
      print("?????????????????????????????????????${ex}");
      // log(ex.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "${ex.toString()}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}
