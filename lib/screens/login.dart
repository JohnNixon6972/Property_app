import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/register.dart';

import '../components/roundedButton.dart';

class login extends StatefulWidget {
  static const String id = 'login';
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //final _auth = FirebaseAuth.instance;

  // String email;
  // String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 251, 246, 246),
        body: SafeArea(
          child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 300,
                          child: Image.asset(
                            'images/loginLogo1.png',
                          ),
                        ),
                      ),
                    ),
                    simpleTexts(
                      texts: 'Login',
                      styleConstant: kTextTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    simpleTexts(
                      texts: 'Please Login In to Continue',
                      styleConstant: kTextSubTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loginCredentials(
                      hintTxt: 'EMAIL',
                      icn: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loginCredentials(hintTxt: 'PASSWORD', icn: Icons.lock),
                    //
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Forgot Password?",
                      textAlign: TextAlign.right,
                      style: kTextTitleStyle.copyWith(fontSize: 17),
                    ),
                    RoundButton(
                      color: Color(0XFF4ECED5),
                      buttonTitle: 'Log In',
                      onPrssed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        // try {

                        //   final existingUser = await _auth.signInWithEmailAndPassword(
                        //       email: email, password: password);

                        //   if (existingUser != null ) {
                        //     Navigator.pushNamed(context, ChatScreen.id);
                        //   }
                        //   setState(() {
                        //     showSpinner = false;
                        //   });
                        // } catch (e) {
                        //   print(e);
                        // }
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          simpleTexts(
                            texts: 'Dont have an account?',
                            styleConstant: kTextSubTitleStyle,
                          ),
                          simpleTexts(
                            texts: 'Sign Up',
                            styleConstant:
                                kTextTitleStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, register.id);
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}

class loginCredentials extends StatelessWidget {
  final String hintTxt;
  final IconData icn;
  loginCredentials({required this.hintTxt, required this.icn});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      textAlign: TextAlign.left,
      decoration: kTextFieldDecoration.copyWith(
          hintText: hintTxt,
          prefixIcon: Icon(
            icn,
            color: Colors.blueGrey,
          )),
    );
  }
}

class simpleTexts extends StatelessWidget {
  final String texts;
  final styleConstant;
  simpleTexts({required this.texts, required this.styleConstant});

  @override
  Widget build(BuildContext context) {
    return Text(
      texts,
      style: styleConstant,
    );
  }
}
