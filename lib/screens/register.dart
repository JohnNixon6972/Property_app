import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/login.dart';

class register extends StatefulWidget {
  static const String id = 'register';

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late String name;
  late String email;
  late String mobileNumber;
  late String addressLine1;
  late String addressLine2;
  late String password;
  late String city;
  late String state;
  late String country;
  late String postalCode;

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/try11.png",
              ),
              fit: BoxFit.contain,
              opacity: 400,
            ),
          ),
          child: SizedBox(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Personal Details :",
                        style: kTextTitleStyle.copyWith(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            name = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Name.',
                          prefixIcon:
                              Icon(Icons.badge, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            mobileNumber = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Mobile Number.',
                          prefixIcon:
                              Icon(Icons.phone, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                          prefixIcon:
                              Icon(Icons.email, color: Color(0XFF4ECED5)),
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
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Address :",
                        style: kTextTitleStyle.copyWith(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            addressLine1 = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Address line 1',
                          prefixIcon:
                              Icon(Icons.home, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            addressLine2 = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Address line 2',
                          prefixIcon:
                              Icon(Icons.house, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            city = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'City',
                          prefixIcon: Icon(Icons.location_city,
                              color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            state = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'State',
                          prefixIcon:
                              Icon(Icons.cabin, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            country = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Country',
                          prefixIcon:
                              Icon(Icons.countertops, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.blue.shade900),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid text';
                          } else {
                            postalCode = value;
                          }

                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Postal code',
                          prefixIcon:
                              Icon(Icons.code, color: Color(0XFF4ECED5)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, login.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0XFF4ECED5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      // RoundButton(
                      //   color: Color(0XFF4ECED5),
                      //   buttonTitle: 'Register',
                      //   onPrssed: () async {
                      //     if (_formKey.currentState!.validate()) {
                      //       // If the form is valid, display a snackbar. In the real world,
                      //       // you'd often call a server or save the information in a database.
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(content: Text('Processing Data')),
                      //       );
                      //     }
                      //     setState(() {
                      //       showSpinner = true;
                      //       Navigator.pushNamed(context, register.id);

                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
