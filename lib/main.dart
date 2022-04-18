import 'package:flutter/material.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(PropertyApp());

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: profileScreen.id,
      routes: {
        loginScreen.id: (context) => loginScreen(),
        registerScreen.id: (context) => registerScreen(),
        profileScreen.id : (context) => profileScreen(),
      },
    );
  }
}
