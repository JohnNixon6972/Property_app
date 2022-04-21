import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

late String firstName;
late String lastName;
late String email;
late String mobileNumber;
late String addressLine1;
late String addressLine2;
late String password;
late String city;
late String state;
late String country;
late String postalCode;
late String phone_num;

List<List<Widget>> fields = [
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid text';
        } else {
          firstName = value;
        }

        return null;
      },
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Enter your Firstname.',
        prefixIcon: Icon(Icons.badge, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid text';
        } else {
          lastName = value;
        }

        return null;
      },
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Enter your Lastname.',
        prefixIcon: Icon(Icons.badge_outlined, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
  ],
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
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
        prefixIcon: Icon(Icons.email, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
  ],
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid text';
        } else {
          phone_num = value;
        }

        return null;
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
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
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
        prefixIcon: Icon(Icons.lock, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
  ],
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.home, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.house, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.location_city, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.cabin, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.countertops, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextFormField(
      cursorColor: kPrimaryButtonColor,
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
        prefixIcon: Icon(Icons.code, color: kPrimaryButtonColor),
      ),
    ),
    SizedBox(
      height: 10,
    ),
  ],
];
