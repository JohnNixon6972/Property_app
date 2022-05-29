
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/aboutUs.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/addPropertiesScreen2.dart';
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/editPropertyScreen1.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/screens/myPropertiesScreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/searchScreen.dart';
import 'screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/homescreen.dart';
import './screens/bookmarkedpropertiesscreen.dart';
import 'screens/addPropertiesScreen2.dart';
import './screens/previewProperty.dart';
import 'currentUserInformation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/otpVerification.dart';
import 'components/forgotpassword.dart';

getUserDetails userInfo = getUserDetails();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  runApp(PropertyApp(prefs: prefs));
}


class PropertyApp extends StatefulWidget {
  SharedPreferences prefs;
  PropertyApp({required this.prefs});
  @override
  State<PropertyApp> createState() => _PropertyAppState(prefs:prefs);
}

class _PropertyAppState extends State<PropertyApp> {
  SharedPreferences prefs;
  _PropertyAppState({required this.prefs});
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: loginScreen.id,
        // initialRoute: VerifyPhoneNumberScreen.id,
        routes: {
          loginScreen.id: (context) => loginScreen(),
          registerScreen.id: (context) => registerScreen(),
          profileScreen.id: (context) => profileScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          myPropertiesScreen.id: (context) => myPropertiesScreen(),
          // PropertyDetailsScreen.id: (context) => PropertyDetailsScreen(),
          BookmarkedPropertiesScreen.id: (context) =>
              BookmarkedPropertiesScreen(),
          AddPropertiesScreen.id: (context) => AddPropertiesScreen(),
          searchScreen.id: (context) => searchScreen(),
          AddPropertiesScreen2.id: (context) => AddPropertiesScreen2(),
          VerifyPhoneNumberScreen.id: (context) => VerifyPhoneNumberScreen(),
          aboutUs.id: (context) => aboutUs(),
          forgotPasswordScreen.id: (context) => forgotPasswordScreen(),
        },
      ),
    );
  }
}
