// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../constants.dart';
import 'dart:math';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: camel_case_types
class aboutUs extends StatefulWidget {
  static const id = 'aboutUs';

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  bool admin = false;
  bool developers = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.rotate(
                  angle: 270 * pi / 180,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.expand_less_rounded,
                      size: 30,
                      color: kHighlightedTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                const Center(
                  child: Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: kHighlightedTextColor),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: kHighlightedTextColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Admin",
                    style: TextStyle(
                        color: kHighlightedTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FlutterSwitch(
                    activeColor: kBottomNavigationBackgroundColor,
                    inactiveColor: kNavigationIconColor,
                    width: 70.0,
                    height: 35.0,
                    // valueFontSize: 25.0,
                    toggleSize: 25.0,
                    value: admin,
                    borderRadius: 30.0,
                    padding: 8.0,
                    // showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        admin = val;
                        developers = !val;
                        // val1 = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Developers",
                    style: TextStyle(
                        color: kHighlightedTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FlutterSwitch(
                    activeColor: kBottomNavigationBackgroundColor,
                    inactiveColor: kNavigationIconColor,
                    width: 70.0,
                    height: 35.0,
                    // valueFontSize: 25.0,
                    toggleSize: 25.0,
                    value: developers,
                    borderRadius: 30.0,
                    padding: 8.0,
                    // showOnOff: true,
                    onToggle: (val1) {
                      setState(() {
                        developers = val1;
                        admin = !val1;
                        // val = false;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
