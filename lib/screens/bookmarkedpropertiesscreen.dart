import 'package:flutter/material.dart';
// import 'package:sticky_headers/sticky_headers.dart';
import '../constants.dart';
import 'dart:math';
import 'propertyDetailsScreen.dart';
import '../components/bottomNavigationBar.dart';

class BookmarkedPropertiesScreen extends StatelessWidget {
  static const id = 'BookmarkedPropertiesScreen';
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
            ),
            Divider(
              thickness: 1,
              indent: 60,
              endIndent: 60,
              color: kSubCategoryColor,
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

class BookmarkedProperties extends StatefulWidget {
  const BookmarkedProperties({
    Key? key,
  }) : super(key: key);

  @override
  State<BookmarkedProperties> createState() => _BookmarkedPropertiesState();
}

class _BookmarkedPropertiesState extends State<BookmarkedProperties> {
  late bool bookedmark = true;
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
                  height: 200,
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
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              // textDirection: ,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PropertyDetailsScreen.id);
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(color: kPrimaryButtonColor),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      bookedmark = !bookedmark;
                    });
                  },
                  icon: Icon(
                    bookedmark ? Icons.bookmark : Icons.bookmark_outline,
                    color: bookedmark
                        ? kHighlightedTextColor
                        : kNavigationIconColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
