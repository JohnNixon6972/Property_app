// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:property_app/screens/homescreen.dart';
import '../constants.dart';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import '../components/bottomNavigationBar.dart';

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
        body: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Image(
                  width: double.infinity,
                  // height: 250,
                  image: AssetImage('images/propertyDetailed1.jpg'),
                ),
                Positioned(
                    bottom: -60,
                    left: 135,
                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundColor: kPageBackgroundColor,
                      radius: 58,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image(
                          height: 110,
                          width: 110,
                          image: AssetImage('images/profile_img1.jpg'),
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 65, bottom: 18),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Devon Lane',
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          wordSpacing: -1),
                    ),
                    Text(
                      'weaver@example.com',
                      style: TextStyle(
                          color: kSubCategoryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            ProfileDetailsContainer(
              icon: Icons.account_circle_outlined,
              Title: "Personal Information",
              SubTitle: "Devon Lane",
            ),
            ProfileDetailsContainer(
              icon: Icons.alternate_email_outlined,
              Title: "Email",
              SubTitle: "weaver@email.com",
            ),
            ProfileDetailsContainer(
              icon: Icons.call_outlined,
              Title: "Phone",
              SubTitle: "(217) 555-0113",
            ),
            ProfileDetailsContainer(
              icon: Icons.lock_outlined,
              Title: "Password",
              SubTitle: "Last updated March 25,2020",
            ),
            ProfileDetailsContainer(
              icon: Icons.settings,
              Title: "Settings",
              SubTitle: "Custom",
            ),
            BottomPageNavigationBar(
              flex_by: 1,page: profileScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailsContainer extends StatelessWidget {
  final IconData icon;
  final String Title;
  final String SubTitle;
  ProfileDetailsContainer(
      {required this.icon, required this.Title, required this.SubTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: kBottomNavigationBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 70,
        // color: kSecondaryButtonColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: kPageBackgroundColor,
                child: Icon(
                  icon,
                  size: 32,
                  color: kNavigationIconColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      Title,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    SubTitle,
                    style: TextStyle(
                        color: kNavigationIconColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.expand_less_rounded,
                    color: kNavigationIconColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// Text(
//                     "Address :",
//                     style: kTextTitleStyle.copyWith(fontSize: 18),
//                     textAlign: TextAlign.left,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         addressLine1 = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Address line 1',
//                       prefixIcon:
//                           Icon(Icons.home, color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         addressLine2 = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Address line 2',
//                       prefixIcon:
//                           Icon(Icons.house, color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         city = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'City',
//                       prefixIcon: Icon(Icons.location_city,
//                           color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         state = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'State',
//                       prefixIcon:
//                           Icon(Icons.cabin, color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         country = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Country',
//                       prefixIcon:
//                           Icon(Icons.countertops, color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.streetAddress,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: kPrimaryButtonColor),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid text';
//                       } else {
//                         postalCode = value;
//                       }

//                       return null;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Postal code',
//                       prefixIcon: Icon(Icons.code, color: kNavigationIconColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
  