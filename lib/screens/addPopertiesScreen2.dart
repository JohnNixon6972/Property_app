import '../constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddPropertiesScreen2 extends StatefulWidget {
  static const String id = 'addPropertiesScreen2';
  @override
  State<AddPropertiesScreen2> createState() => _AddPropertiesScreen2State();
}

class _AddPropertiesScreen2State extends State<AddPropertiesScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.rotate(
              angle: 270 * pi / 180,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.expand_less_rounded,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Add Properties',
                    style: TextStyle(
                        color: kHighlightedTextColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Text(
                    'Step 1/2',
                    style: TextStyle(
                        color: kSubCategoryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
