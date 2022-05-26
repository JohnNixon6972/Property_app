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

  await prefs.clear();
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

    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: userAvailable ? HomeScreen.id : loginScreen.id,
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
          aboutUs.id : (context) => aboutUs(), 
          
        },
      ),
    );
  }
}
