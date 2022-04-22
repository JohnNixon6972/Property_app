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

// // Grey Color Scheme
// const kPageBackgroundColor = Color.fromARGB(255, 236, 236, 236);
// const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
// const kPrimaryButtonColor = Color.fromARGB(255, 38, 38, 38);
// const kSecondaryButtonColor = Color.fromARGB(255, 236, 236, 236);
// const kHighlightedTextColor = Color(0xff5F9FFE);
// const kNavigationIconColor = Color.fromARGB(255, 188, 188, 188);

// // Orange Color Scheme
// const kPageBackgroundColor = Color(0xffF5DEB4);
// const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
// const kPrimaryButtonColor = Color(0xffC78024);
// const kSecondaryButtonColor = Color.fromARGB(255, 236, 236, 236);
// const kHighlightedTextColor = Color(0xff5F9FFE);
// const kNavigationIconColor = Color.fromARGB(255, 188, 188, 188);
// const kBottomNavigationBackgroundColor = Color(0xffD7AC81);
// const kPropertyCardColor = Color(0xffFCB07A);

// Beige Color Scheme
// const kPageBackgroundColor = Color(0xffECE8E0);
// const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
// const kPrimaryButtonColor = Color.fromARGB(255, 9, 70, 32);
// const kSecondaryButtonColor = Color.fromARGB(255, 236, 236, 236);
// const kHighlightedTextColor = Color.fromARGB(255, 9, 70, 32);
// const kNavigationIconColor = Color.fromARGB(255, 188, 188, 188);
// const kBottomNavigationBackgroundColor = Colors.white;
// const kPropertyCardColor = Colors.white;
// const kTextFieldFillColor = Color.fromARGB(255, 226, 223, 218);

const kPageBackgroundColor = Color.fromARGB(255, 238, 244, 248);
const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
const kPrimaryButtonColor = Color(0xff4B6274);
const kSecondaryButtonColor = Color.fromARGB(255, 236, 236, 236);
const kHighlightedTextColor = Color(0xff4B6274);
const kNavigationIconColor = Color.fromARGB(255, 188, 188, 188);
const kBottomNavigationBackgroundColor = Color.fromARGB(255, 238, 244, 248);
const kPropertyCardColor = Color.fromARGB(255, 151, 151, 151);
const kTextFieldFillColor = Color.fromARGB(255, 226, 223, 218);

// // Green Color Scheme
// const kPageBackgroundColor = Color(0xffD6F3E1);
// const kSubCategoryColor = Color.fromARGB(255, 151, 151, 151);
// const kPrimaryButtonColor = Color.fromARGB(255, 107, 227, 169);
// const kSecondaryButtonColor = Color(0xffD6F3E1);
// const kHighlightedTextColor = Color(0xff5F9FFE);
// const kNavigationIconColor = Color.fromARGB(255, 188, 188, 188);
