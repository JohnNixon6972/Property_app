import 'package:flutter/material.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/homescreen.dart';
import '/screens/propertyDetailsScreen.dart';
import './screens/bookmarkedpropertiesscreen.dart';

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
        profileScreen.id: (context) => profileScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PropertyDetailsScreen.id: (context) => PropertyDetailsScreen(),
        BookmarkedPropertiesScreen.id:(context) =>BookmarkedPropertiesScreen()
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Here it Begins'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
