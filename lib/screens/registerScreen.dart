import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/currentUserInformation.dart';
import '../components/alertPopUp.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import '../components/otpVerification.dart';

// final TextEditingController _otpController = TextEditingController();

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _formKey = GlobalKey<FormState>();

class registerScreen extends StatefulWidget {
  static const String id = 'register';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _auth = FirebaseAuth.instance;
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
    physics:
    const BouncingScrollPhysics();
    var _passwordController;
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 400,
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
                        texts: 'Personal Details :',
                        styleConstant: kTextTitleStyle.copyWith(fontSize: 25),
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.name = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kPrimaryButtonColor),
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
                          prefixIcon:
                              Icon(Icons.badge, color: kNavigationIconColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.mobileNumber = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kPrimaryButtonColor),
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
                          prefixIcon:
                              Icon(Icons.phone, color: kNavigationIconColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //   onChanged: (value) {
                      //     userInfo.email = value;
                      //   },
                      //   cursorColor: kPrimaryButtonColor,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(color: kPrimaryButtonColor),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter valid text';
                      //     } else {
                      //       userInfo.email = value;
                      //     }

                      //     return null;
                      //   },
                      //   decoration: kTextFieldDecoration.copyWith(
                      //     hintText: 'Enter your Email Address.',
                      //     prefixIcon:
                      //         Icon(Icons.email, color: kNavigationIconColor),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      TextFormField(
                        onChanged: (value) {
                          userInfo.password = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        obscureText: _isHidden,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kPrimaryButtonColor),
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
                          prefixIcon:
                              Icon(Icons.lock, color: kNavigationIconColor),
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
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // print("hi");
                          // await otpVerification();
                          Navigator.pushNamed(
                              context, VerifyPhoneNumberScreen.id);

                          // otpDialogBox(BuildContext context) {
                          //   return
                          // verifyPhoneNumber(context);
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return new AlertDialog(
                          //         title: Text('Enter your OTP'),
                          //         content: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: TextFormField(
                          //             decoration: InputDecoration(
                          //               border: new OutlineInputBorder(
                          //                 borderRadius: const BorderRadius.all(
                          //                   const Radius.circular(30),
                          //                 ),
                          //               ),
                          //             ),
                          //             onChanged: (value) {
                          //               otp = value;
                          //             },
                          //           ),
                          //         ),
                          //         contentPadding: EdgeInsets.all(10.0),
                          //         actions: <Widget>[
                          //           FlatButton(
                          //             onPressed: () {
                          //               // Navigator.of(context).pop();
                          //               Navigator.pop(context);
                          //               signIn(otp);
                          //             },
                          //             child: Text(
                          //               'Submit',
                          //             ),
                          //           ),
                          //         ],
                          //       );
                          //     });
                          // }
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
                      SizedBox(
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
                      SizedBox(
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

  // Future<FirebasePhoneAuthHandler> otpVerification() async {
  //   print("sending otp");
  //   return FirebasePhoneAuthHandler(
  //     phoneNumber: userInfo.mobileNumber,
  //     onLoginSuccess: (userCredential, autoVerified) async {
  //       Navigator.pushNamed(context, HomeScreen.id);
  //       msg:
  //       autoVerified
  //           ? 'OTP was fetched automatically!'
  //           : 'OTP was verified manually!';

  //       // showSnackBar('Phone number verified successfully!');

  //       // log(
  //       //   VerifyPhoneNumberScreen.id,
  //       //   msg: 'Login Success UID: ${userCredential.user?.uid}',
  //       // );

  //       Navigator.pushNamedAndRemoveUntil(
  //         context,
  //         HomeScreen.id,
  //         (route) => false,
  //       );
  //     },
  //     onLoginFailed: (authException) {
  //       // showSnackBar('Something went wrong!');
  //       // log(VerifyPhoneNumberScreen.id, error: authException.message);
  //       print("login failed");
  //       // handle error further if needed
  //     },
  //     builder: (context, controller) {
  //       return Scaffold(
  //         appBar: AppBar(
  //           leadingWidth: 0,
  //           leading: const SizedBox.shrink(),
  //           title: const Text('Verify Phone Number'),
  //           actions: [
  //             if (controller.codeSent)
  //               TextButton(
  //                 child: Text(
  //                   controller.timerIsActive
  //                       ? '${controller.timerCount.inSeconds}s'
  //                       : 'Resend',
  //                   style: const TextStyle(color: Colors.blue, fontSize: 18),
  //                 ),
  //                 onPressed: controller.timerIsActive
  //                     ? null
  //                     : () async {
  //                         // log(registerScreen.id,
  //                         //     msg: 'Resend OTP');
  //                         await controller.sendOTP();
  //                       },
  //               ),
  //             const SizedBox(width: 5),
  //           ],
  //         ),
  //         body: controller.codeSent
  //             ? ListView(
  //                 padding: const EdgeInsets.all(20),
  //                 controller: scrollController,
  //                 children: [
  //                   Text(
  //                     "We've sent an SMS with a verification code to ${userInfo}",
  //                     style: const TextStyle(fontSize: 25),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   const Divider(),
  //                   if (controller.timerIsActive)
  //                     Column(
  //                       children: const [
  //                         // CustomLoader(),
  //                         SizedBox(height: 50),
  //                         Text(
  //                           'Listening for OTP',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             fontSize: 25,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                         ),
  //                         SizedBox(height: 15),
  //                         Divider(),
  //                         Text('OR', textAlign: TextAlign.center),
  //                         Divider(),
  //                       ],
  //                     ),
  //                   const SizedBox(height: 15),
  //                   const Text(
  //                     'Enter OTP',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 15),
  //                   OTPTextField(
  //                     length: 6,
  //                     onChanged: (hasFocus) async {
  //                       if (hasFocus != null)
  //                         await _scrollToBottomOnKeyboardOpen();
  //                     },
  //                     onCompleted: (enteredOTP) async {
  //                       final isValidOTP = await controller.verifyOTP(
  //                         otp: enteredOTP,
  //                       );
  //                       // Incorrect OTP
  //                       if (!isValidOTP) {
  //                         // showSnackBar(
  //                         //     'The entered OTP is invalid!');
  //                         print("invalid otp");
  //                       }
  //                     },
  //                   ),
  //                 ],
  //               )
  //             : Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: const [
  //                   // CustomLoader(),
  //                   SizedBox(height: 50),
  //                   Center(
  //                     child: Text(
  //                       'Sending OTP',
  //                       style: TextStyle(fontSize: 25),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //       );
  //     },
  //   );
  // }
  // onLoginSuccess: (UserCredential, autoVerified) {
  //   debugPrint("autoVerified: $autoVerified");
  //   debugPrint("Login success UID: ${UserCredential.user?.uid}");
  // },
  // onLoginFailed: (authException) {
  //   debugPrint("An error occurred: ${authException.message}");
  // },

  // Future<void> signIn(String otp) async {
  //   await FirebaseAuth.instance
  //       .signInWithCredential(PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: otp,
  //   ));
  // }

  // Future<void> verifyPhoneNumber(BuildContext context) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: userInfo.mobileNumber,
  //     timeout: Duration(seconds: 15),
  //     verificationCompleted: (AuthCredential authCredential) {
  //       setState(() {
  //         authStatus = "Your account is successfully verified";
  //       });
  //     },
  //     verificationFailed: (FirebaseAuthException authException) {
  //       setState(() {
  //         authStatus = "Authentication failed";
  //       });
  //     },
  //     codeSent: (String verId, int? forceCodeResent) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "OTP has been successfully send";
  //       });
  //       // otpDialogBox(context).then((value) {});
  //     },
  //     codeAutoRetrievalTimeout: (String verId) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "TIMEOUT";
  //       });
  //     },
  //   );
  // }
}


// String otp, authStatus = "";
//                           String phoneNumber, verificationId;

//                           await FirebaseAuth.instance.verifyPhoneNumber(
//                               phoneNumber: userInfo.mobileNumber,
//                               verificationCompleted:
//                                   (AuthCredential authCredential) {
//                                 setState(() {
//                                   authStatus =
//                                       "Your account is successfully verified";
//                                 });
//                               },
//                               verificationFailed:
//                                   (FirebaseAuthException authException) {
//                                 setState(() {
//                                   authStatus = "Authentication failed";
//                                 });
//                               },
//                               codeSent: (String verId, int? forceCodeResent) {
//                                 verificationId = verId;
//                                 setState(() {
//                                   authStatus = "OTP has been successfully send";
//                                 });
//                               },
//                               codeAutoRetrievalTimeout: (String verId) {
//                                 verificationId = verId;
//                                 setState(() {
//                                   authStatus = "TIMEOUT";
//                                 });
//                               });




  // Future signUp() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) return;

  //   popUpAlertDialogBox(context, "Invalid cerdentials");

  //   // }
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: userInfo.email, password: userInfo.password);
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }


                          // var validateStatus = false;
                          // if (_formKey.currentState!.validate()) {
                          //   // Timer _timer = Timer(Duration(seconds: 30), () {
                          //   //   Navigator.of(context).pop();
                          //   // });
                          //   // var user = _auth.currentUser!;
                          //   // await user.reload();
                          //   // if (user.emailVerified) {
                          //   //   _timer.cancel();
                          //   //   Navigator.pushNamed(context, HomeScreen.id);
                          //   // }
                          //   try {
                          //     // Timer _timer = Timer(Duration(seconds: 30), () {
                          //     //   Navigator.of(context).pop();
                          //     // });
                          //     // // Future<void> checkEmailVerified() async {
                          //     // var user = _auth.currentUser!;
                          //     // await user.reload();
                          //     // if (user.emailVerified) {
                          //     //   _timer.cancel();
                          //     //   Navigator.pushNamed(context, HomeScreen.id);
                          //     // }
                          //     // }

                          //     print(userInfo.email);
                          //     print(userInfo.password);

                          //     // EmailAuth emailAuth =
                          //     //     new EmailAuth(sessionName: "Sample Session");

                          //     // bool result = await emailAuth.sendOtp(
                          //     //     recipientMail: userInfo.email, otpLength: 6);

                          //     // if (result == true) {
                          //     //   Timer _timer;
                          //     //   var pin;
                          //     //   var finalresult;
                          //     //   var otp;
                          //     //   showDialog(
                          //     //     context: context,
                          //     //     builder: (BuildContext builderContext) {
                          //     //       return Column(
                          //     //         children: [
                          //     //           Card(
                          //     //             child: OTPTextField(
                          //     //               length: 6,
                          //     //               width: MediaQuery.of(context)
                          //     //                   .size
                          //     //                   .width,
                          //     //               fieldWidth: 50,
                          //     //               otpFieldStyle: OtpFieldStyle(
                          //     //                 borderColor: kNavigationIconColor,
                          //     //               ),
                          //     //               style: TextStyle(fontSize: 17),
                          //     //               textFieldAlignment:
                          //     //                   MainAxisAlignment.spaceAround,
                          //     //               fieldStyle: FieldStyle.underline,
                          //     //               onCompleted: (pin) {
                          //     //                 otp = pin;
                          //     //                 print("Completed: " + pin);
                          //     //               },
                          //     //               onChanged: (pin) {
                          //     //                 otp = pin;
                          //     //               },
                          //     //             ),
                          //     //           ),
                          //     //           ElevatedButton(
                          //     //             onPressed: () async {
                          //     //               Navigator.pop(context);
                          //     //               try {
                          //     //                 finalresult =
                          //     //                     await emailAuth.validateOtp(
                          //     //                         recipientMail:
                          //     //                             userInfo.email,
                          //     //                         userOtp: otp);
                          //     //                 Navigator.pushNamed(
                          //     //                     context, HomeScreen.id);
                          //     //                 setState(() {
                          //     //                   validateStatus = finalresult;
                          //     //                 });
                          //     //               } on FirebaseAuthException catch (error) {
                          //     //                 switch (error.message) {
                          //     //                   case 'The email address is badly formatted.':
                          //     //                     popUpAlertDialogBox(
                          //     //                         context, "Invalid Email");
                          //     //                     break;
                          //     //                   case 'The email address is already in use by another account.':
                          //     //                     popUpAlertDialogBox(context,
                          //     //                         "User Already exists");
                          //     //                     break;
                          //     //                   case 'Password should be at least 6 characters':
                          //     //                     popUpAlertDialogBox(context,
                          //     //                         "Password should be atleast 6 characters");
                          //     //                     break;

                          //     //                   default:
                          //     //                     print(
                          //     //                         'Case ${error} is not yet implemented');
                          //     //                     break;
                          //     //                 }
                          //     //               } catch (e) {
                          //     //                 popUpAlertDialogBox(
                          //     //                     context, "Invalid OTP");
                          //     //                 // popUpAlertDialogBox(context, "Invalid Email");
                          //     //                 print("here = $e");
                          //     //               }
                          //     //             },
                          //     //             style: ElevatedButton.styleFrom(
                          //     //               primary: kPrimaryButtonColor,
                          //     //               shape: RoundedRectangleBorder(
                          //     //                 borderRadius:
                          //     //                     BorderRadius.circular(25),
                          //     //               ),
                          //     //             ),
                          //     //             child: const Text(
                          //     //               'Verify OTP',
                          //     //               style: TextStyle(
                          //     //                   color: Colors.white,
                          //     //                   fontSize: 20),
                          //     //             ),
                          //     //           ),
                          //     //         ],
                          //     //       );
                          //     //     },
                          //     //   );
                          //     //   // await Future.delayed(Duration(seconds: 30));
                          //     // }

                          //     // if (validateStatus == true) {
                          //     _firestore
                          //         .collection("Users")
                          //         .doc(userInfo.email)
                          //         .set({
                          //       "email": userInfo.email,
                          //       "name": userInfo.name,
                          //       "number": userInfo.mobileNumber
                          //     });
                          //     print("hey");
                          //     final newUser =
                          //         await _auth.createUserWithEmailAndPassword(
                          //             email: userInfo.email,
                          //             password: userInfo.password);
                          //     Navigator.pushNamed(context, HomeScreen.id);
                          //     // } else {
                          //     //   popUpAlertDialogBox(context, "Invalid Email");
                          //     // }
                          //   } on FirebaseAuthException catch (error) {
                          //     switch (error.message) {
                          //       case 'The email address is badly formatted.':
                          //         popUpAlertDialogBox(context, "Invalid Email");
                          //         break;

                          //       case 'The email address is already in use by another account.':
                          //         popUpAlertDialogBox(
                          //             context, "User Already exists");
                          //         break;

                          //       case 'Password should be at least 6 characters':
                          //         popUpAlertDialogBox(context,
                          //             "Password should be atleast 6 characters");
                          //         break;

                          //       default:
                          //         print('Case ${error} is not yet implemented');
                          //         break;
                          //     }
                          //   } catch (e) {
                          //     // popUpAlertDialogBox(context, "Invalid Email");
                          //     print("only here = $e");
                          //   }
                          //   ;
                          // }
