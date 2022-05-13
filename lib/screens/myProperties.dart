import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_app/main.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
import '../components/bottomNavigationBar.dart';

class myProperties extends StatelessWidget {
  static const id = 'myProperties';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Center(
                    child: Text(
                      'My Properties',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kHighlightedTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 60,
              endIndent: 60,
              color: kHighlightedTextColor,
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BookmarkedProperties(),
                      SizedBox(
                        height: 10,
                      ),
                      BookmarkedProperties(),
                      SizedBox(
                        height: 10,
                      ),
                      BookmarkedProperties(),
                    ],
                  ),
                ),
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 1,
              page: BookmarkedPropertiesScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}
