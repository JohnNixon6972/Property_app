import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/register.dart';

class login extends StatefulWidget {
  static const String id = 'login';
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
      backgroundColor: Color.fromARGB(255, 251, 246, 246),
      body: SafeArea(
        child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Form(
              key: _formKey,
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
                            'images/try1.png',
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
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blue.shade900),
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
                        prefixIcon: Icon(Icons.email, color: Color(0XFF4ECED5)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blue.shade900),
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
                        prefixIcon: Icon(Icons.lock, color: Color(0XFF4ECED5)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        style: kTextTitleStyle.copyWith(fontSize: 17),
                      ),
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
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0XFF4ECED5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
              ),
            )),
      ),
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
