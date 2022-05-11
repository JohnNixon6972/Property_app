import 'package:firebase_auth/firebase_auth.dart';
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
import './screens/bookmarkedpropertiesscreen.dart';
import './screens/addPopertiesScreen2.dart';
import './screens/previewProperty.dart';
import 'currentUserInformation.dart';
import 'package:shared_preferences/shared_preferences.dart';

getUserDetails userInfo = getUserDetails();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getUser();
  runApp(PropertyApp());
}

bool userAvailable = false;
final _auth = FirebaseAuth.instance;

Future<void> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  

  // await prefs.clear();
  String? savedUser = await prefs.getString("User");
  String? savedPassword = await prefs.getString("Password");

  if (savedUser != null && savedPassword != null) {
    print("Saved User :" + savedUser);
    print("Saved Password :" + savedPassword);
    _auth.signInWithEmailAndPassword(
        email: savedUser.toString(), password: savedPassword.toString());
    userAvailable = true;
  }
}

class PropertyApp extends StatefulWidget {
  @override
  State<PropertyApp> createState() => _PropertyAppState();
}

class _PropertyAppState extends State<PropertyApp> {
  @override
  Widget build(BuildContext context) {
    print(userAvailable);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: userAvailable ? HomeScreen.id : loginScreen.id,
      routes: {
        loginScreen.id: (context) => loginScreen(),
        registerScreen.id: (context) => registerScreen(),
        profileScreen.id: (context) => profileScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        // PropertyDetailsScreen.id: (context) => PropertyDetailsScreen(),
        BookmarkedPropertiesScreen.id: (context) =>
            BookmarkedPropertiesScreen(),
        AddPropertiesScreen.id: (context) => AddPropertiesScreen(),
        searchScreen.id: (context) => searchScreen(),
        AddPropertiesScreen2.id: (context) => AddPropertiesScreen2(),
        PreviewProperty.id: (context) => PreviewProperty(),
      },
    );
  }
}
