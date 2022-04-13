import 'package:flutter/material.dart';

const kTextTitleStyle = TextStyle(
  color: Color(0XFF4ECED5),
  fontWeight: FontWeight.bold,
  fontSize: 40.0,
);

const kTextSubTitleStyle = TextStyle(
  color: Colors.blueGrey,
  // fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.blueGrey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  prefixIcon: Icon(
    Icons.mail,
    color: Colors.blueGrey,
  ),
  // fillColor: Color(0XFF4ECED5),
  // hoverColor: Colors.lightBlueAccent,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0XFF4ECED5), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 29, 148, 154), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
