import 'dart:ffi';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image(
                      // width: 800,
                      // height: 500,
                      image: AssetImage('images/backgroundProfileImage3.png'),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: 145,
                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundColor: kPageBackgroundColor,
                      radius: 53,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('images/profile_img1.jpg'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
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
            ),
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
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
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 2,
              page: profileScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailsContainer extends StatefulWidget {
  final IconData icon;
  final String Title;
  final String SubTitle;

  ProfileDetailsContainer(
      {required this.icon, required this.Title, required this.SubTitle});

  @override
  State<ProfileDetailsContainer> createState() =>
      _ProfileDetailsContainerState();
}

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

class _ProfileDetailsContainerState extends State<ProfileDetailsContainer> {
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
                  widget.icon,
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
                      widget.Title,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.SubTitle,
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
                    print("Tapped");
                    // Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (_) => editDetailsPopup(
                            "Personal Information", personalInformation));
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

  SimpleDialog editDetailsPopup(String boxTitle, List<Widget> childern) {
    return SimpleDialog(
      backgroundColor: kPageBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(boxTitle),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: childern,
            ),
          ),
        ),
      ],
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
                  // TextFormField(
                  //   keyboardType: TextInputType.streetAddress,
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(color: kPrimaryButtonColor),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter valid text';
                  //     } else {
                  //       addressLine1 = value;
                  //     }

                  //     return null;
                  //   },
                  //   decoration: kTextFieldDecoration.copyWith(
                  //     hintText: 'Address line 1',
                  //     prefixIcon:
                  //         Icon(Icons.home, color: kNavigationIconColor),
                  //   ),
                  // ),
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
  