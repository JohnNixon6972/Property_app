import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/registerScreen.dart';
import 'package:property_app/currentUserInformation.dart';
import 'package:property_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextEditingController _otpController = TextEditingController();

// late String email;
// late String password;

class loginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  //final _auth = FirebaseAuth.instance;

  // String email;
  // String password;
  bool showSpinner = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Form(
            key: _loginFormKey,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 400,
                        child: Image.asset(
                          'images/try1.png',
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            simpleTexts(
                              texts: 'Login',
                              styleConstant: kTextTitleStyle,
                              align: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            simpleTexts(
                              texts: 'Please Login to Continue',
                              styleConstant: kTextSubTitleStyle,
                              align: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: kPrimaryButtonColor,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: kPrimaryButtonColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email address';
                            } else {
                              userInfo.email = value;
                            }

                            return null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your Email Address.',
                            prefixIcon:
                                Icon(Icons.email, color: kNavigationIconColor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Forgot Password ?",
                                textAlign: TextAlign.right,
                                style: kTextTitleStyle.copyWith(fontSize: 17),
                              ),
                            ],
                          ),
                          onTap: () async {
                            final _auth = FirebaseAuth.instance;
                            // FirebaseAuth.instance
                            //     .sendPasswordResetEmail(email: userInfo.email);
                            showDialog(
                              context: context,
                              builder: (_) => SimpleDialog(
                                backgroundColor: kPageBackgroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text(
                                  "Reset password",
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                onChanged: (newValue) {
                                                  userInfo.email = newValue;
                                                  print(userInfo.email);
                                                },
                                                cursorColor:
                                                    kPrimaryButtonColor,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: kPrimaryButtonColor),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter valid text';
                                                  } else {
                                                    userInfo.email = value;
                                                  }

                                                  // return null;
                                                },
                                                decoration: kTextFieldDecoration
                                                    .copyWith(
                                                  hintText:
                                                      'Enter your Email Address.',
                                                  prefixIcon: Icon(Icons.email,
                                                      color:
                                                          kPrimaryButtonColor),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  setState(
                                                    () {
                                                      if (_loginFormKey
                                                          .currentState!
                                                          .validate()) {}
                                                      FirebaseAuth.instance
                                                          .sendPasswordResetEmail(
                                                              email: userInfo
                                                                  .email);
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPrimaryButtonColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Request link',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_loginFormKey.currentState!.validate()) {
                              print(userInfo.email);
                              print(userInfo.password);
                              try {
                                var match =
                                    await _auth.signInWithEmailAndPassword(
                                        email: userInfo.email,
                                        password: userInfo.password);
                                // print(match);
                                // if (match == true) {
                                  await prefs.setString('User', userInfo.email);
                                  await prefs.setString(
                                      'Password', userInfo.password);
                                } else {
                                  Timer _timer;
                                  _timer = Timer(Duration(seconds: 5), () {
                                    Navigator.of(context).pop();
                                  });

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext builderContext) {
                                        _timer =
                                            Timer(Duration(seconds: 5), () {
                                          Navigator.of(context).pop();
                                        });

                                        return AlertDialog(
                                          backgroundColor:
                                              kBottomNavigationBackgroundColor,
                                          title: Text('Login In Failed'),
                                        );
                                      }).then((val) {});
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Login',
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
                                texts: 'Dont have an account? ',
                                styleConstant: kTextSubTitleStyle,
                                align: TextAlign.center,
                              ),
                              simpleTexts(
                                texts: 'Sign Up',
                                styleConstant:
                                    kTextTitleStyle.copyWith(fontSize: 18),
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, registerScreen.id);
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
      ),
    );
  }
}

class simpleTexts extends StatelessWidget {
  final String texts;
  final styleConstant;
  final TextAlign align;
  simpleTexts(
      {required this.texts, required this.styleConstant, required this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      texts,
      style: styleConstant,
      textAlign: align,
    );
  }
}
