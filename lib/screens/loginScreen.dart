import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/components/forgotpassword.dart';
import 'package:property_app/components/otpVerification.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/registerScreen.dart';
import 'package:property_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/alertPopUp.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class loginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  State<loginScreen> createState() => _loginScreenState();
}

Future<void> checkSavedUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final _firestore = FirebaseFirestore.instance;

  String? SavedUserNum = prefs.getString("UserNum");
  String? SavedPassword = prefs.getString("SavedPassword");
  print(SavedUserNum);
  print(SavedPassword);

  if (SavedPassword != null && SavedUserNum != null) {
    await _firestore
        .collection('Users')
        .doc(SavedUserNum)
        .get()
        .then((value) => {
              // print(value.data()!["password"]),
              if (value.exists)
                {
                  if (SavedPassword == (value.data()!["password"]))
                    {
                      userInfo.name = value.data()!["name"],
                      userInfo.password = value.data()!["password"],
                      userInfo.email = value.data()!["email"],
                      userInfo.mobileNumber = value.data()!["mobileNumber"],
                      userInfo.addressLine1 = value.data()!["addressLine1"],
                      userInfo.addressLine2 = value.data()!["addressLine2"],
                      userInfo.state = value.data()!["state"],
                      userInfo.country = value.data()!["country"],
                      userInfo.postalCode = value.data()!["postalcode"],
                      userInfo.profileImgUrl = value.data()!["profileImgUrl"],
                      print("Login Successful"),
                      print("Set Local Storage"),
                      print(prefs.getString("UserNum")),
                      print(prefs.getString("SavedPassword")),
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.id, (route) => false),
                    }
                }
            });
  }
}

class _loginScreenState extends State<loginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkSavedUser(context);
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();
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
                physics: const BouncingScrollPhysics(),
                child: Column(
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
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: kPrimaryButtonColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid Moible Number';
                            } else {
                              userInfo.mobileNumber = value;
                            }
                            return null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your registered Mobile Number',
                            prefixIcon: Icon(Icons.phone,
                                color: kBottomNavigationBackgroundColor),
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
                            prefixIcon: Icon(Icons.lock,
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
                                title: const Text(
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
                                                  userInfo.mobileNumber =
                                                      newValue;
                                                  print(userInfo.mobileNumber);
                                                },
                                                cursorColor:
                                                    kPrimaryButtonColor,
                                                keyboardType:
                                                    TextInputType.phone,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: kPrimaryButtonColor),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter valid text';
                                                  }
                                                },
                                                decoration: kTextFieldDecoration
                                                    .copyWith(
                                                  hintText:
                                                      'Enter your Mobile Number.',
                                                  prefixIcon: Icon(Icons.phone,
                                                      color:
                                                          kPrimaryButtonColor),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  bool userExists = false;
                                                  _firestore
                                                      .collection("Users")
                                                      .doc(
                                                          userInfo.mobileNumber)
                                                      .get()
                                                      .then((value) => {
                                                            print("hi"),
                                                            userExists = true,
                                                            Navigator.pushNamed(
                                                                context,
                                                                forgotPasswordScreen
                                                                    .id)
                                                          });
                                                  if (userExists == false) {
                                                    popUpAlertDialogBox(context,
                                                        "User is not registered");
                                                  }
                                                  // if (_loginFormKey
                                                  //     .currentState!
                                                  //     .validate()) {}
                                                  // FirebaseAuth.instance
                                                  //     .sendPasswordResetEmail(
                                                  //         email: userInfo
                                                  //             .email);

                                                  // FirebaseAuth.instance.send

                                                  Navigator.pop(context);
                                                  print(userInfo.mobileNumber);
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
                                                  'Request OTP',
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
                            if (_loginFormKey.currentState!.validate()) {
                              print(userInfo.mobileNumber);
                              print(userInfo.password);
                              try {
                                //   await _auth.signInWithEmailAndPassword(
                                //       email: userInfo.email,
                                //       password: userInfo.password);

                                final _firestore = FirebaseFirestore.instance;

                                _firestore
                                    .collection('Users')
                                    .doc(userInfo.mobileNumber)
                                    .get()
                                    .then((value) => {
                                          // print(value.data()!["password"]),
                                          if (value.exists)
                                            {
                                              if (userInfo.password ==
                                                  (value.data()!["password"]))
                                                {
                                                  userInfo.name =
                                                      value.data()!["name"],
                                                  userInfo.password =
                                                      value.data()!["password"],
                                                  userInfo.email =
                                                      value.data()!["email"],
                                                  userInfo.mobileNumber = value
                                                      .data()!["mobileNumber"],
                                                  userInfo.addressLine1 = value
                                                      .data()!["addressLine1"],
                                                  userInfo.addressLine2 = value
                                                      .data()!["addressLine2"],
                                                  userInfo.state =
                                                      value.data()!["state"],
                                                  userInfo.country =
                                                      value.data()!["country"],
                                                  userInfo.postalCode = value
                                                      .data()!["postalcode"],
                                                  userInfo.profileImgUrl = value
                                                      .data()!["profileImgUrl"],
                                                  print("Login Successful"),
                                                  print("Set Local Storage"),
                                                  prefs.setString('UserNum',
                                                      userInfo.mobileNumber),
                                                  prefs.setString(
                                                      'SavedPassword',
                                                      userInfo.password),
                                                  print(prefs
                                                      .getString("UserNum")),
                                                  print(prefs.getString(
                                                      "SavedPassword")),
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          HomeScreen.id,
                                                          (route) => false),
                                                }
                                              else
                                                {
                                                  popUpAlertDialogBox(
                                                      context, "Login Failed"),
                                                }
                                            }
                                          else
                                            {
                                              popUpAlertDialogBox(context,
                                                  "${userInfo.mobileNumber} is not registered"),
                                            }
                                        });

                                await prefs.setString(
                                    'User', userInfo.mobileNumber);
                                await prefs.setString(
                                    'Password', userInfo.password);
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
                                styleConstant: kTextTitleStyle.copyWith(
                                  fontSize: 18,
                                ),
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
