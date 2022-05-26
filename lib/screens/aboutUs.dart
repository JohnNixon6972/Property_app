// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../constants.dart';
import 'dart:math';

// ignore: camel_case_types
class aboutUs extends StatefulWidget {
  static const id = 'aboutUs';

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
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
          ],
        ),
      ),
    );
  }
}
