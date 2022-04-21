import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

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

List<Widget> personalInformation = [
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
      prefixIcon: Icon(Icons.home, color: kNavigationIconColor),
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
      prefixIcon: Icon(Icons.house, color: kNavigationIconColor),
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
      prefixIcon: Icon(Icons.location_city, color: kNavigationIconColor),
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
      prefixIcon: Icon(Icons.cabin, color: kNavigationIconColor),
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
      prefixIcon: Icon(Icons.countertops, color: kNavigationIconColor),
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
];

List<Widget> email_address = [
  
];
