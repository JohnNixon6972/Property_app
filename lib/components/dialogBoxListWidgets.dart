import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/profileScreen.dart';

final _formKey = GlobalKey<FormState>();
List<List<Widget>> fields = [
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      onChanged: (newValue) {
        name = newValue;
        print(name);
      },
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid text';
        } else {
          name = value;
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
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      onChanged: (newValue) {
        email = newValue;
        print(email);
      },
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

        // return null;
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
      onChanged: (newValue) {
        mobileNumber = newValue;
        print(mobileNumber);
      },
      cursorColor: kPrimaryButtonColor,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.left,
      style: TextStyle(color: kPrimaryButtonColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid text';
        } else {
          mobileNumber = value;
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
  [
    SizedBox(
      height: 10,
    ),
    TextFormField(
      onChanged: (newValue) {
        password = newValue;
        print(password);
      },
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

        // return null;
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
      onChanged: (newValue) {
        addressLine1 = newValue;
        print(addressLine1);
      },
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
        addressLine2 = newValue;
        print(addressLine2);
      },
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
        city = newValue;
        print(city);
      },
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
        state = newValue;
        print(state);
      },
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
        country = newValue;
        print(country);
      },
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
        postalCode = newValue;
        print(postalCode);
      },
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
];
