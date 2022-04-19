import 'package:flutter/material.dart';
import '../constants.dart';

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPageBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FormField(
            key: _formKey,
            builder: (FormFieldState<dynamic> field) {
              var selectedValue;
              return Column(
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //decoration for the outer wrapper
                      color: kPrimaryButtonColor,
                      borderRadius: BorderRadius.circular(
                          30), //border radius exactly to ClipRRect
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: ClipRRect(
                      //to clip overflown positioned containers.
                      borderRadius: BorderRadius.circular(30),
                      //if we set border radius on container, the overflown content get displayed at corner.
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            //Stack helps to overlap widgets
                            Positioned(
                              //positioned helps to position widget wherever we want.
                              top: -20,
                              left: -50, //position of the widget
                              child: Container(
                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kBottomNavigationBackgroundColor
                                        .withOpacity(
                                            0.5) //background color with opacity
                                    ),
                              ),
                            ),

                            Positioned(
                              left: -80,
                              top: -50,
                              child: Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPageBackgroundColor,
                                ),
                              ),
                            ),

                            Positioned(
                              //main content container postition.
                              child: Container(
                                height: 250,
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    child: Image(
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/try8.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                    style: TextStyle(color: kPrimaryButtonColor),
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
                          Icon(Icons.home, color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kPrimaryButtonColor),
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
                          Icon(Icons.house, color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kPrimaryButtonColor),
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
                          color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kPrimaryButtonColor),
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
                          Icon(Icons.cabin, color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kPrimaryButtonColor),
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
                          Icon(Icons.countertops, color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kPrimaryButtonColor),
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
                      prefixIcon: Icon(Icons.code, color: kNavigationIconColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
