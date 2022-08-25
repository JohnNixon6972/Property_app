import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'package:property_app/components/pinInputField.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'customLoader.dart';
import '../main.dart';
import '../screens/homescreen.dart';
import '../currentUserInformation.dart';

late String newPassword = userInfo.password;
late String confirmNewPassword = userInfo.password;

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _formKey = GlobalKey<FormState>();

class forgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgotPasswordScreen';

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: "+91" + userInfo.mobileNumber,
        onLoginSuccess: (userCredential, autoVerified) async {
          // _firestore.collection('Users').doc(userInfo.mobileNumber).set({
          //   "name": userInfo.name,
          //   "password": userInfo.password,
          //   "email": userInfo.email,
          //   "mobileNumber": userInfo.mobileNumber,
          //   "addressLine1": userInfo.addressLine1,
          //   "addressLine2": userInfo.addressLine2,
          //   "city": userInfo.city,
          //   "state": userInfo.state,
          //   "country": userInfo.country,
          //   "postalcode": userInfo.postalCode,
          //   "profileImgUrl": userInfo.profileImgUrl,
          // });

          log(
            forgotPasswordScreen.id,
            name: autoVerified
                ? 'OTP was fetched automatically!'
                : 'OTP was verified manually!',
          );

          // showSnackBar('Phone number verified successfully!');

          log(
            forgotPasswordScreen.id,
            name: 'Login Success UID: ${userCredential.user?.uid}',
          );
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   loginScreen.id,
          //   (route) => false,
          // );
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              backgroundColor: kPageBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text(
                "Set New Password",
                style: TextStyle(
                  color: kHighlightedTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Form(
                        // key: _loginFormKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                newPassword = value;
                                // print("New Password Entered");
                              },
                              cursorColor: kPrimaryButtonColor,
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(color: kPrimaryButtonColor),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid text';
                                }
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your new password.',
                                prefixIcon: const Icon(Icons.lock,
                                    color: kPrimaryButtonColor),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              // controller: _confirmNewPassowrd,
                              onChanged: (value) {
                                confirmNewPassword = value;
                              },
                              cursorColor: kPrimaryButtonColor,
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(color: kPrimaryButtonColor),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid text';
                                }
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Confirm your new password.',
                                prefixIcon: const Icon(Icons.lock_open,
                                    color: kPrimaryButtonColor),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                setState(
                                  () {
                                    bool userExists = false;

                                    _firestore
                                        .collection("Users")
                                        .doc(userInfo.mobileNumber)
                                        .get()
                                        .then((value) => {
                                              userExists = true,
                                              if (newPassword ==
                                                  confirmNewPassword)
                                                {
                                                  userInfo.password =
                                                      newPassword,
                                                  _firestore
                                                      .collection("Users")
                                                      .doc(
                                                          userInfo.mobileNumber)
                                                      .update({
                                                    "password": newPassword
                                                  }),
                                                  Navigator.pushNamed(
                                                      context, loginScreen.id),
                                                }
                                              else
                                                {
                                                  popUpAlertDialogBox(context,
                                                      "Passwords Don't match"),
                                                }
                                            });

                                    if (userExists == false) {
                                      popUpAlertDialogBox(
                                          context, "User is not registered");
                                    }
                                  },
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onLoginFailed: (authException, StackTrace) {
          // showSnackBar('Something went wrong!');
          log(forgotPasswordScreen.id, error: authException.message);
          // handle error further if needed
        },
        builder: (context, controller) {
          try {
            return Scaffold(
              backgroundColor: kPageBackgroundColor,
              appBar: AppBar(
                toolbarHeight: 70,
                backgroundColor: kBottomNavigationBackgroundColor,
                leadingWidth: 0,
                leading: const SizedBox.shrink(),
                title: Center(
                  child: Text(
                    'Verify Phone Number',
                    style: TextStyle(
                      color: kHighlightedTextColor,
                      fontSize: 23,
                    ),
                  ),
                ),
                actions: [
                  if (controller.codeSent)
                    TextButton(
                      child: Text(
                        controller.isListeningForOtpAutoRetrieve
                            ? '${controller.autoRetrievalTimeLeft.inSeconds}s'
                            : 'Resend',
                        style: const TextStyle(
                            color: kHighlightedTextColor, fontSize: 18),
                      ),
                      onPressed: controller.isListeningForOtpAutoRetrieve
                          ? null
                          : () async {
                              log(forgotPasswordScreen.id, name: 'Resend OTP');
                              await controller.sendOTP();
                            },
                    ),
                  const SizedBox(width: 5),
                ],
              ),
              body: controller.codeSent
                  ? ListView(
                      padding: const EdgeInsets.all(20),
                      controller: scrollController,
                      children: [
                        Text(
                          "We've sent an SMS with a verification code to " +
                              userInfo.mobileNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: kHighlightedTextColor),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          thickness: 1,
                          color: kHighlightedTextColor,
                        ),
                        if (controller.isListeningForOtpAutoRetrieve)
                          Column(
                            children: const [
                              CustomLoader(),
                              SizedBox(height: 50),
                              Text(
                                'Listening for OTP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: kHighlightedTextColor),
                              ),
                              SizedBox(height: 15),
                              Divider(
                                thickness: 1,
                                color: kHighlightedTextColor,
                              ),
                              Text(
                                'OR',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kHighlightedTextColor),
                              ),
                              Divider(
                                thickness: 1,
                                color: kHighlightedTextColor,
                              ),
                            ],
                          ),
                        const SizedBox(height: 15),
                        const Text(
                          'Enter OTP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kHighlightedTextColor),
                        ),
                        const SizedBox(height: 15),
                        PinInputField(
                          length: 6,
                          onFocusChange: (hasFocus) async {
                            if (hasFocus) await _scrollToBottomOnKeyboardOpen();
                          },
                          onSubmit: (enteredOTP) async {
                            var smsCode = "xxxx";
                            final isValidOTP = await controller.verifyOtp(
                              enteredOTP,
                            );
                            // PhoneAuthCredential phoneAuthCredential =
                            //     PhoneAuthProvider.credential(
                            //         verificationId: userInfo.mobileNumber,
                            //         smsCode: enteredOTP);

                            // await _auth
                            //     .signInWithCredential(phoneAuthCredential);
                            // Incorrect OTP
                            if (!isValidOTP) {
                              // showSnackBar('The entered OTP is invalid!');
                            }
                          },
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CustomLoader(),
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            'Sending OTP',
                            style: TextStyle(
                                fontSize: 25, color: kHighlightedTextColor),
                          ),
                        ),
                      ],
                    ),
            );
          } catch (e) {
            print(e);
            return Center();
          }
        },
      ),
    );
  }
}
