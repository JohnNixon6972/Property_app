import 'package:flutter/material.dart';
import '../constants.dart';

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // CircleAvatar(backgroundImage: Image(image: "images/try13.wep"),)
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.blue.shade900),
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
                    prefixIcon: Icon(Icons.home, color: Color(0XFF4ECED5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  new Container(
//       height: 150.0,
//       margin: new EdgeInsets.all(10.0),
//       decoration: new BoxDecoration(
//         borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
//         gradient: new LinearGradient(
//             colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade200],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             tileMode: TileMode.clamp),
//       ),
//     );
