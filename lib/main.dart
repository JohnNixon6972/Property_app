import 'package:flutter/material.dart';
import './screens/homescreen.dart';
import '/screens/propertyDetailsScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Here it Begins'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      initialRoute: PropertyDetailsScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        PropertyDetailsScreen.id: (context) => PropertyDetailsScreen()
      },
    ),
  );
}
