// ignore_for_file: camel_case_types, use_key_in_widget_constructors, override_on_non_overriding_member, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/loginScreen.dart';
import '../components/alertPopUp.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import '../components/otpVerification.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:otp_text_field/otp_field_style.dart';
// import 'package:property_app/screens/homescreen.dart';
// import 'package:property_app/currentUserInformation.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// final TextEditingController _otpController = TextEditingController();

class registerScreen extends StatefulWidget {
  static const String id = 'register';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  // final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  // late String phoneNumber, verificationId = "";
  late String otp = " ", authStatus = "";

  bool showSpinner = false;
  bool _isHidden = true;

  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    // WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance?.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance!.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 350,
                      child: Image.asset(
                        'images/try11.png',
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      simpleTexts(
                        texts: 'Personal Details',
                        styleConstant: kTextTitleStyle.copyWith(fontSize: 25),
                        align: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.name = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: kPrimaryButtonColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            userInfo.name = value;
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Name.',
                          prefixIcon: const Icon(Icons.badge,
                              color: kBottomNavigationBackgroundColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.mobileNumber = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: kPrimaryButtonColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            userInfo.mobileNumber = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Mobile Number.',
                          prefixIcon: const Icon(Icons.phone,
                              color: kBottomNavigationBackgroundColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.password = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        obscureText: _isHidden,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: kPrimaryButtonColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            userInfo.password = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Password.',
                          prefixIcon: const Icon(Icons.lock,
                              color: kBottomNavigationBackgroundColor),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            child: Icon(_isHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          _firestore
                              .collection("Users")
                              .doc(userInfo.mobileNumber)
                              .get()
                              .then((doc) => {
                                    if (doc.exists)
                                      {
                                        popUpAlertDialogBox(context,
                                            "${userInfo.mobileNumber} is already registered"),
                                        // Navigator.pushNamed(
                                        //     context, loginScreen.id),
                                      }
                                    else
                                      {
                                        Navigator.pushNamed(context,
                                            VerifyPhoneNumberScreen.id),
                                      }
                                  });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            simpleTexts(
                              texts: 'Already have an account? ',
                              styleConstant: kTextSubTitleStyle,
                              align: TextAlign.center,
                            ),
                            simpleTexts(
                              texts: 'Sign In',
                              styleConstant:
                                  kTextTitleStyle.copyWith(fontSize: 18),
                              align: TextAlign.center,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, loginScreen.id);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// await _auth.verifyPhoneNumber(
                          //   phoneNumber: "+91 " + userInfo.mobileNumber,
                          //   timeout: const Duration(seconds: 60),
                          //   verificationCompleted:
                          //       (PhoneAuthCredential credential) async {
                          //     await _auth.signInWithCredential(credential);
                          //   },
                          //   verificationFailed: (FirebaseAuthException e) {
                          //     if (e.code == 'invalid-phone-number') {
                          //       print(
                          //           'The provided phone number is not valid.');
                          //     }
                          //   },
                          //   codeSent: (String verificationId,
                          //       int? resendToken) async {
                          //     String smsCode = 'xxxx';
                          //     PhoneAuthCredential credential =
                          //         PhoneAuthProvider.credential(
                          //             verificationId: verificationId,
                          //             smsCode: smsCode);
                          //     await _auth.signInWithCredential(credential);
                          //   },
                          //   codeAutoRetrievalTimeout:
                          //       (String verificationId) {},
                          // );