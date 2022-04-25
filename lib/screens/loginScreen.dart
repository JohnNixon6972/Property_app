import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/registerScreen.dart';

class loginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  // final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  //final _auth = FirebaseAuth.instance;

  // String email;
  // String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Form(
            key: _formKey,
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
                              return 'Please enter valid text';
                            } else {
                              email = value;
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
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: kPrimaryButtonColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid text';
                            } else {
                              password = value;
                            }

                            return null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your Password.',
                            prefixIcon:
                                Icon(Icons.lock, color: kNavigationIconColor),
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
                            //     try {
                            //   final newUser =
                            //       await _auth.
                            //   if (newUser != null) {
                            //     Navigator.pushNamed(context, login.id);
                            //   }
                            //   setState(() {
                            //     showSpinner = false;
                            //   });
                            // } catch (e) {
                            //   print(e);
                            // }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
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
