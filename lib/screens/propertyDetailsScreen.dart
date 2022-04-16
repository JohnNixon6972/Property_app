import 'package:flutter/material.dart';
import 'dart:math';

class PropertyDetailsScreen extends StatelessWidget {
  static const id = 'propertyDetailsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 270 * pi / 180,
                  child: Icon(
                    Icons.expand_less_rounded,
                    size: 30,
                  ),
                ),
                Center(
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
