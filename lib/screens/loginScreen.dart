import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/registerScreen.dart';
import 'package:property_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/alertPopUp.dart';

class loginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();
  bool showSpinner = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    physics:
    const BouncingScrollPhysics();
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
                              return 'Please enter valid Moible Number';
                            } else {
                              userInfo.email = value;
                            }
                            return null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your registered Mobile Number',
                            prefixIcon:
                                Icon(Icons.phone, color: kNavigationIconColor),
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
                            if (_loginFormKey.currentState!.validate()) {
                              print(userInfo.mobileNumber);
                              print(userInfo.password);
                              try {
                                //   await _auth.signInWithEmailAndPassword(
                                //       email: userInfo.email,
                                //       password: userInfo.password);
                                await prefs.setString(
                                    'User', userInfo.mobileNumber);
                                await prefs.setString(
                                    'Password', userInfo.password);
                                
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                              //on FirebaseAuthException catch (error) {
                              //   switch (error.message) {
                              //     // case 'The email address is badly formatted.':
                              //     //   popUpAlertDialogBox(
                              //     //       context, "Invalid Email");
                              //     //   break;

                              //     case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                              //       popUpAlertDialogBox(
                              //           context, "User Not Registered");
                              //       break;

                              //     case 'The password is invalid or the user does not have a password.':
                              //       popUpAlertDialogBox(
                              //           context, "Invalid Password");
                              //       break;

                              //     case 'We have blocked all requests from this device due to unusual activity. Try again later.':
                              //       popUpAlertDialogBox(context,
                              //           "Session Time Out.\nTry again later.");
                              //       break;

                              //     default:
                              //       print(
                              //           'Case ${error} is not yet implemented');

                              //       break;
                              //   }
                              // }
                              catch (e) {
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


// var validateStatus;
//                           if (_formKey.currentState!.validate()) {
//                             try {
//                               print(userInfo.email);
//                               print(userInfo.password);

//                               EmailAuth emailAuth =
//                                   new EmailAuth(sessionName: "Sample Session");

//                               bool result = await emailAuth.sendOtp(
//                                   recipientMail: userInfo.email, otpLength: 5);

//                               Timer _timer;
//                               var pin;
//                               var finalresult;

//                               var otp;
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext builderContext) {
//                                   _timer = Timer(Duration(seconds: 30), () {
//                                     Navigator.of(context).pop();
//                                   });
//                                   return Column(
//                                     children: [
//                                       Card(
//                                         child: OTPTextField(
//                                           length: 6,
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           fieldWidth: 50,
//                                           otpFieldStyle: OtpFieldStyle(
//                                             borderColor: kNavigationIconColor,
//                                           ),
//                                           style: TextStyle(fontSize: 17),
//                                           textFieldAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           fieldStyle: FieldStyle.underline,
//                                           onCompleted: (pin) {
//                                             otp = pin;
//                                             print("Completed: " + pin);
//                                           },
//                                           onChanged: (pin) {},
//                                         ),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           finalresult =
//                                               await emailAuth.validateOtp(
//                                                   recipientMail: userInfo.email,
//                                                   userOtp: otp);
//                                           validateStatus = finalresult;
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: kPrimaryButtonColor,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(25),
//                                           ),
//                                         ),
//                                         child: const Text(
//                                           'Verify OTP',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                               await Future.delayed(Duration(seconds: 20));

//                               if (validateStatus == true) {
//                                 _firestore
//                                     .collection("Users")
//                                     .doc(userInfo.email)
//                                     .set({
//                                   "email": userInfo.email,
//                                   "name": userInfo.name,
//                                   "number": userInfo.mobileNumber
//                                 });
//                                 try {
//                                   final newUser = await _auth
//                                       .createUserWithEmailAndPassword(
//                                           email: userInfo.email,
//                                           password: userInfo.password);
//                                   Navigator.pushNamed(context, HomeScreen.id);
//                                 } on FirebaseAuthException catch (error) {
//                                   switch (error.message) {
//                                     case 'The email address is badly formatted.':
//                                       popUpAlertDialogBox(
//                                           context, "Invalid Email");
//                                       break;
//                                     case 'The email address is already in use by another account.':
//                                       popUpAlertDialogBox(
//                                           context, "User Already exists");
//                                       break;
//                                     case 'Password should be at least 6 characters':
//                                       popUpAlertDialogBox(context,
//                                           "Password should be atleast 6 characters");
//                                       break;

//                                     default:
//                                       popUpAlertDialogBox(
//                                           context, "Invalid Email");
//                                       break;
//                                   }
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               } else {
//                                 popUpAlertDialogBox(
//                                     context, "Session Time Out");
//                               }
//                             } on FirebaseAuthException catch (error) {
//                               switch (error.message) {
//                                 case 'The email address is badly formatted.':
//                                   popUpAlertDialogBox(context, "Invalid Email");
//                                   break;
//                                 case 'The email address is already in use by another account.':
//                                   popUpAlertDialogBox(
//                                       context, "User Already exists");
//                                   break;
//                                 case 'Password should be at least 6 characters':
//                                   popUpAlertDialogBox(context,
//                                       "Password should be atleast 6 characters");
//                                   break;

//                                 default:
//                                   print('Case ${error} is not yet implemented');
//                                   break;
//                               }
//                             } catch (e) {
//                               popUpAlertDialogBox(context, "Invalid Email");
//                             }
//                             ;
//                           }
