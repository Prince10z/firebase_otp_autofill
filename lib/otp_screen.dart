import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:phone_authenticaiton_flutter/Controller/otpscreen.dart';
import 'package:phone_authenticaiton_flutter/Functions/otpmethods.dart';
import 'package:phone_authenticaiton_flutter/advancedWidgets/count_animation.dart';
import 'package:phone_authenticaiton_flutter/home_screen.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen(
      {super.key, required this.verificationid, required this.phonenumber});
  String verificationid;
  String phonenumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isloading = false;
  late TextEditingController otpController;
  late TextEditingController firstotpController;
  late TextEditingController secondotpController;
  late TextEditingController thirdotpController;
  late TextEditingController forthotpController;
  late TextEditingController fifthotpController;
  late TextEditingController sixthotpController;
  late OtpControllers testotpcontroller;
  late FocusNode firstnode;
  late FocusNode secondnode;
  late FocusNode thirdnode;
  late FocusNode forthnode;
  late FocusNode fifthnode;
  late FocusNode sixthnode;
  // Future<dynamic> executeFinal() async {
  //   try {
  //     _isloading = true;
  //     PhoneAuthCredential credential =
  //         // await PhoneAuthProvider.credential(
  //         //     verificationId: widget.verificationid,
  //         //     smsCode: otpController.text.trim().toString());
  //         await PhoneAuthProvider.credential(
  //             verificationId: widget.verificationid,
  //             smsCode: firstotpController.text.trim().toString() +
  //                 secondotpController.text.trim().toString() +
  //                 thirdotpController.text.trim().toString() +
  //                 forthotpController.text.trim().toString() +
  //                 fifthotpController.text.trim().toString() +
  //                 sixthotpController.text.trim().toString());
  //     FirebaseAuth.instance.signInWithCredential(credential).then((value) {
  //       _isloading = false;
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     });
  //   } catch (ex) {
  //     _isloading = false;
  //     print("?????????????????????????????????????${ex}");
  //     log(ex.toString());
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         "${ex.toString()}",
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    testotpcontroller = Get.put(OtpControllers());
    // otpController = TextEditingController();
    firstotpController = TextEditingController();
    secondotpController = TextEditingController();
    thirdotpController = TextEditingController();
    forthotpController = TextEditingController();
    fifthotpController = TextEditingController();
    sixthotpController = TextEditingController();
    firstnode = FocusNode();
    secondnode = FocusNode();
    thirdnode = FocusNode();
    forthnode = FocusNode();
    fifthnode = FocusNode();
    sixthnode = FocusNode();
    firstnode.requestFocus();
    testotpcontroller.runCount();
  }

  static void nextText(
      {required FocusNode nextnode,
      required TextEditingController currentController}) {
    if (currentController.text.trim().length == 1) {
      nextnode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_isloading == true)
            Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4)),
            ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(),
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      otptextfield(
                          node: firstnode,
                          controller: firstotpController,
                          nextnode: secondnode),
                      otptextfield(
                          node: secondnode,
                          controller: secondotpController,
                          nextnode: thirdnode),
                      otptextfield(
                          node: thirdnode,
                          controller: thirdotpController,
                          nextnode: forthnode),
                      otptextfield(
                          node: forthnode,
                          controller: forthotpController,
                          nextnode: fifthnode),
                      otptextfield(
                          node: fifthnode,
                          controller: fifthotpController,
                          nextnode: sixthnode),
                      otptextfield(
                          node: sixthnode,
                          controller: sixthotpController,
                          nextnode: null),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Obx(() => ElevatedButton(
                  onPressed: () {
                    if (testotpcontroller.count.value == 0) {
                      testotpcontroller.reset();
                      Otpmethods.phoneAuthentication(
                          widget.phonenumber, context, false);
                    }
                  },
                  child: SizedBox(
                    height: 6.h,
                    width: 25.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        testotpcontroller.showbutton.value == true
                            ? Text("Resend OTP")
                            : Text("Wait"),
                        if (testotpcontroller.count.value != 0)
                          Container(
                            width: 40,
                            height: 40,
                            child: ClipOval(
                              child: CustomPaint(
                                painter: CountdownPainter(
                                  testotpcontroller.count.value / 30,
                                ),
                                child: Center(
                                  child: Text(
                                    testotpcontroller.count.value.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ))),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("${MediaQuery.of(context).size.width}");
                    if (firstotpController.text.trim().length +
                            secondotpController.text.trim().length +
                            thirdotpController.text.trim().length +
                            forthotpController.text.trim().length +
                            fifthotpController.text.trim().length +
                            sixthotpController.text.trim().length ==
                        6) {
                      await Otpmethods.executeFinal(
                          verificationid: widget.verificationid,
                          context: context,
                          firstotp: firstotpController.text,
                          secondotp: secondotpController.text,
                          thirdotp: thirdotpController.text,
                          forthotp: forthotpController.text,
                          fifthotp: fifthotpController.text,
                          sixthotp: sixthotpController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "fill the OTP please...",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }
                    // try {
                    //   PhoneAuthCredential credential =
                    //       // await PhoneAuthProvider.credential(
                    //       //     verificationId: widget.verificationid,
                    //       //     smsCode: otpController.text.trim().toString());
                    //       await PhoneAuthProvider.credential(
                    //           verificationId: widget.verificationid,
                    //           smsCode: firstotpController.text.trim().toString() +
                    //               secondotpController.text.trim().toString() +
                    //               thirdotpController.text.trim().toString() +
                    //               forthotpController.text.trim().toString() +
                    //               fifthotpController.text.trim().toString() +
                    //               sixthotpController.text.trim().toString());
                    //   FirebaseAuth.instance
                    //       .signInWithCredential(credential)
                    //       .then((value) {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => HomeScreen()));
                    //   });
                    // } catch (ex) {
                    //   print("?????????????????????????????????????${ex}");
                    //   log(ex.toString());
                    // }
                  },
                  child: Text("Verify otp"))
            ],
          ),
        ],
      ),
    );
  }

  Widget otptextfield(
      {required dynamic node,
      required dynamic controller,
      required dynamic nextnode}) {
    return SizedBox(
      height: 25.h,
      width: 12.w,
      child: TextFormField(
          keyboardType: TextInputType.number,
          focusNode: node,
          controller: controller,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val) async {
            if (val.isNotEmpty) {
              if (nextnode != null) {
                nextText(nextnode: nextnode, currentController: controller);
              } else {
                if (firstotpController.text.trim().length +
                        secondotpController.text.trim().length +
                        thirdotpController.text.trim().length +
                        forthotpController.text.trim().length +
                        fifthotpController.text.trim().length +
                        sixthotpController.text.trim().length ==
                    6) {
                  await Otpmethods.executeFinal(
                      verificationid: widget.verificationid,
                      context: context,
                      firstotp: firstotpController.text,
                      secondotp: secondotpController.text,
                      thirdotp: thirdotpController.text,
                      forthotp: forthotpController.text,
                      fifthotp: fifthotpController.text,
                      sixthotp: sixthotpController.text);
                }
              }
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          )),
    );
  }
}
