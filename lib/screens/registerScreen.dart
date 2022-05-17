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
import 'alertPopUp.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

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
  late String phoneNumber, verificationId;
  late String otp = " ", authStatus = "";

  bool showSpinner = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
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
                          // otpDialogBox(BuildContext context) {
                          //   return
                          verifyPhoneNumber(context);
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: Text('Enter your OTP'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        otp = value;
                                      },
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        signIn(otp);
                                      },
                                      child: Text(
                                        'Submit',
                                      ),
                                    ),
                                  ],
                                );
                              });
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

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: userInfo.mobileNumber,
      timeout: Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, int? forceCodeResent) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        // otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }
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
