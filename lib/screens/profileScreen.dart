import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 150.0,
      margin: new EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade200],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp),
      ),
    );
  }
}
