import 'package:flutter/material.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/addPopertiesScreen2.dart';
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/loginScreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/searchScreen.dart';
import 'screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/homescreen.dart';
import '/screens/propertyDetailsScreen.dart';
import './screens/bookmarkedpropertiesscreen.dart';
import './screens/addPopertiesScreen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PropertyApp());
}

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: loginScreen.id,
      routes: {
        loginScreen.id: (context) => loginScreen(),
        registerScreen.id: (context) => registerScreen(),
        profileScreen.id: (context) => profileScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PropertyDetailsScreen.id: (context) => PropertyDetailsScreen(),
        BookmarkedPropertiesScreen.id: (context) =>
            BookmarkedPropertiesScreen(),
        AddPropertiesScreen.id: (context) => AddPropertiesScreen(),
        searchScreen.id: (context) => searchScreen(),
        AddPropertiesScreen2.id: (context) => AddPropertiesScreen2(),
      },
    );
  }
}
