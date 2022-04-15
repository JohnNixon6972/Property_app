import 'package:flutter/material.dart';
import 'package:property_app/screens/login.dart';
import './screens/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(PropertyApp());

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: login.id,
      routes: {
        login.id: (context) => login(),
        register.id: (context) => register(),
      },
    );
  }
}
