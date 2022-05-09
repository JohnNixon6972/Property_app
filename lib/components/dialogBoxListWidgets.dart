import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';
import '../screens/profileScreen.dart';
import '../screens/loginScreen.dart';
import 'package:property_app/main.dart';
import 'package:property_app/currentUserInformation.dart';
final dialogKey = GlobalKey<FormState>();
final passwordKey = GlobalKey<FormState>();
final TextEditingController _currentPassowrd = TextEditingController();
late String newPassword = "";
late String confirmNewPassword = "";
// bool _isHidden = true;

List<List<Widget>> fields = [
  [
    Form(
      key: dialogKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.name = newValue;
              print(userInfo.name);
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
              // return firstName;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter your Full Name.',
              prefixIcon: Icon(Icons.badge, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  ],
  // [
  //   Form(
  //     key: dialogKey,
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           onChanged: (newValue) {
  //             userInfo.email = newValue;
  //             print(userInfo.email);
  //           },
  //           cursorColor: kPrimaryButtonColor,
  //           keyboardType: TextInputType.emailAddress,
  //           textAlign: TextAlign.left,
  //           style: TextStyle(color: kPrimaryButtonColor),
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'Please enter valid text';
  //             } else {
  //               userInfo.email = value;
  //             }

  //             // return null;
  //           },
  //           decoration: kTextFieldDecoration.copyWith(
  //             hintText: 'Enter your Email Address.',
  //             prefixIcon: Icon(Icons.email, color: kPrimaryButtonColor),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   ),
  // ],
  [
    Form(
      key: dialogKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.mobileNumber = newValue;
              print(userInfo.mobileNumber);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.mobileNumber = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter your Mobile Number.',
              prefixIcon: Icon(Icons.lock, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  ],
  [
    Form(
      key: passwordKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // controller: _currentPassowrd,
            obscureText: true,
            onChanged: (value) {
              userInfo.password = value;
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                // password = currentPassowrd;
                if (_currentPassowrd != userInfo.password) {
                  print("Invalid Password");
                }
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Current Password.',
              prefixIcon: Icon(Icons.lock_outline, color: kPrimaryButtonColor),
              // suffix: InkWell(
              //                 onTap:(){},
              //                 child: Icon(_isHidden
              //                     ? Icons.visibility
              //                     : Icons.visibility_off),
              //               ),
              //             ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              newPassword = value;
              // print("New Password Entered");
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                // password = _newPassowrd as String;
                // print("New Password Entered");
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter your new password.',
              prefixIcon: Icon(Icons.lock, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            // controller: _confirmNewPassowrd,
            onChanged: (value) {
              confirmNewPassword = value;
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                confirmNewPassword = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Confirm your new password.',
              prefixIcon: Icon(Icons.lock_open, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  ],
  [
    Form(
      key: dialogKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.addressLine1 = newValue;
              print(userInfo.addressLine1);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.addressLine1 = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Address line 1',
              prefixIcon: Icon(Icons.home, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.addressLine2 = newValue;
              print(userInfo.addressLine2);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.addressLine2 = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Address line 2',
              prefixIcon: Icon(Icons.house, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.city = newValue;
              print(userInfo.city);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.city = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'City',
              prefixIcon: Icon(Icons.location_city, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.state = newValue;
              print(userInfo.state);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.state = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'State',
              prefixIcon: Icon(Icons.cabin, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.country = newValue;
              print(userInfo.country);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.country = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Country',
              prefixIcon: Icon(Icons.countertops, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (newValue) {
              userInfo.postalCode = newValue;
              print(userInfo.postalCode);
            },
            cursorColor: kPrimaryButtonColor,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.left,
            style: TextStyle(color: kPrimaryButtonColor),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid text';
              } else {
                userInfo.postalCode = value;
              }

              // return null;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Postal code',
              prefixIcon: Icon(Icons.code, color: kPrimaryButtonColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    )
  ],
];

