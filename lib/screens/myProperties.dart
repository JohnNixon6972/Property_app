import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_app/main.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/alertPopUp.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/profileScreen.dart';
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
                    width: 100,
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
              child: ListView(
                // reverse: true,
                padding: EdgeInsets.symmetric(vertical: 10),
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                // children:
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 1,
              page: myProperties.id,
            ),
          ],
        ),
      ),
    );
  }
}

class myProperty extends StatefulWidget {
  @override
  State<myProperty> createState() => _myPropertyState();
}

class _myPropertyState extends State<myProperty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPropertyCardColor,
        border: Border.all(color: kHighlightedTextColor),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 352,
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
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, profileScreen.id);
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
                      // Timer _timer;
                      showDialog(
                          context: context,
                          builder: (BuildContext builderContext) {
                            // _timer = Timer(Duration(seconds: 3), () {
                            //   Navigator.of(context).pop();
                            // });
                            return SimpleDialog(
                              backgroundColor: kPageBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: Text(
                                "Delete Property ?",
                                style: TextStyle(
                                  color: kHighlightedTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      ElevatedButton(
                                        onPressed: () async {},
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              kBottomNavigationBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {},
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryButtonColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
