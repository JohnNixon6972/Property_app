import 'package:flutter/material.dart';

const kTextTitleStyle = TextStyle(
  color: kHighlightedTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 40.0,
);

const kTextSubTitleStyle = TextStyle(
  color: kSubCategoryColor,
  // fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: kSubCategoryColor),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  prefixIcon: Icon(
    Icons.mail,
    color: Color(0XFF4ECED5),
  ),
  // fillColor: Color(0XFF4ECED5),
  // hoverColor: Colors.lightBlueAccent,
  fillColor: kPropertyCardColor,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: kPrimaryButtonColor, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryButtonColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryButtonColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kPageBackgroundColor = Color(0xffE9E3E3);
const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
const kRequestedIconColor = Color.fromARGB(255, 121, 121, 121);
const kPrimaryButtonColor = Color(0xff510055);
const kSecondaryButtonColor = Color(0xffDAD8D9);
const kHighlightedTextColor = Color(0xff510055);
const kNavigationIconColor = Color.fromARGB(255, 211, 199, 199);
const kBottomNavigationBackgroundColor = Color.fromARGB(255, 190, 157, 170);
const kPropertyCardColor = Color(0xffDAD8D9);
const kTextFieldFillColor = Color.fromARGB(255, 211, 199, 199);
const kYes = Color.fromARGB(255, 7, 91, 10);
const kNo = Color.fromARGB(255, 147, 20, 11);
