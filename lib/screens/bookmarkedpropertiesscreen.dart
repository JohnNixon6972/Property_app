import 'package:flutter/material.dart';
// import 'package:sticky_headers/sticky_headers.dart';
import '../constants.dart';
import 'dart:math';
import 'propertyDetailsScreen.dart';

class BookmarkedPropertiesScreen extends StatelessWidget {
  static const id = 'BookmarkedPropertiesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Center(
                    child: Text(
                      'BookMarked Properties',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kHighlightedTextColor),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                indent: 70,
                endIndent: 70,
                color: kSubCategoryColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BookmarkedProperties(),
                      Divider(
                        thickness: 1,
                        color: kNavigationIconColor,
                      ),
                      BookmarkedProperties(),
                      Divider(
                        thickness: 1,
                        color: kNavigationIconColor,
                      ),
                      BookmarkedProperties(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookmarkedProperties extends StatelessWidget {
  const BookmarkedProperties({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPropertyCardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 350,
      // width: 300,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  // width: 170,
                  fit: BoxFit.cover,
                  image: AssetImage('images/propertyDetailed1.jpg'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Nomaden Omah Sekut',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'San Diego, California, USA',
                style: TextStyle(
                  color: kSubCategoryColor,
                ),
              ),
            ),
            Row(
              children: [
                const Text(
                  "\$128 ",
                  style: TextStyle(
                      fontSize: 18,
                      color: kHighlightedTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  " / Month",
                  style: TextStyle(
                      fontSize: 12,
                      color: kSubCategoryColor,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              // textDirection: ,
              children: [
                const SizedBox(
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PropertyDetailsScreen.id);
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: kPrimaryButtonColor),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
