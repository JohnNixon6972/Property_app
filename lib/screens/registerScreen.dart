import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/currentUserInformation.dart';

// late String name = "";
// late String email = "";
// late String mobileNumber = "";
// late String addressLine1 = "";
// late String addressLine2 = "";
// late String password = "";
// late String city = "";
// late String state = "";
// late String country = "";
// late String postalCode = "";

class registerScreen extends StatefulWidget {
  static const String id = 'register';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

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
                      TextFormField(
                        onChanged: (value) {
                          userInfo.email = value;
                        },
                        cursorColor: kPrimaryButtonColor,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kPrimaryButtonColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
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
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            try {
                              print(userInfo.email);
                              print(userInfo.password);
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: userInfo.email,
                                      password: userInfo.password);

                              _firestore
                                  .collection("Users")
                                  .doc(userInfo.email)
                                  .set({
                                "email": userInfo.email,
                                "name": userInfo.name,
                                "number": userInfo.mobileNumber
                              });

                              if (newUser != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
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
}
