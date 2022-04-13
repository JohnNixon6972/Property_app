import 'package:flutter/material.dart';
import 'package:property_app/screens/login.dart';
import './screens/register.dart';

void main() => runApp(PropertyApp());

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: login.id,
      routes: {
        login.id: (context) => login(),
        register.id :(context) => register(),
      },
    );
  }
}
