import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/myPropertiesScreen.dart';

final dialogKey = GlobalKey<FormState>();
final passwordKey = GlobalKey<FormState>();
late String currentPassowrd;
late String newPassword = userInfo.password;
late String confirmNewPassword = userInfo.password;
// bool _isHidden = true;
final _firestore = FirebaseFirestore.instance;

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);
  

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  
  
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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
