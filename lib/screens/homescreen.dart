import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:avatar_glow/avatar_glow.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'homeScreen';
  late AnimationController _animationController;
  late Animation _animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hey Marimar ${Emojis.wavingHandLightSkinTone}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kSubCategoryColor,
                          ),
                        ),
                        Text(
                          "Let's find your your best residence!",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: const Image(
                      image: AssetImage('images/profile_img1.jpg'),
                      height: 70,
                      width: 70,
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            //     child: Center(
            //       child: Material(
            //         elevation: 2,
            //         borderRadius: const BorderRadius.all(
            //           Radius.circular(15),
            //         ),
            //         child: Container(
            //           decoration: const BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(15),
            //             ),
            //           ),
            //           width: 220,
            //           height: 40,
            //           child: Row(
            //             children: const [
            //               Text(
            //                 "  Add Property ",
            //                 style: TextStyle(
            //                     fontSize: 25,
            //                     fontWeight: FontWeight.bold,
            //                     color: Color.fromARGB(255, 164, 164, 164)),
            //               ),
            //               CircleAvatar(
            //                 radius: 17,
            //                 backgroundColor: Color.fromARGB(255, 38, 38, 38),
            //                 child: Icon(
            //                   Icons.home,
            //                   color: Color.fromARGB(255, 228, 228, 228),
            //                   size: 25,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CategoryCard(
                      btn_color: kPrimaryButtonColor,
                      text: 'All',
                      width: 60,
                      text_color: Colors.white,
                    ),
                    CategoryCard(
                      btn_color: kSecondaryButtonColor,
                      text: 'Appartment',
                      width: 90,
                      text_color: kSubCategoryColor,
                    ),
                    CategoryCard(
                      btn_color: kSecondaryButtonColor,
                      text: 'Townhouse',
                      width: 90,
                      text_color: kSubCategoryColor,
                    ),
                    CategoryCard(
                      btn_color: kSecondaryButtonColor,
                      text: 'Villa',
                      width: 60,
                      text_color: kSubCategoryColor,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 32,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Text(
                          'Best for you ${Emojis.smilingFaceWithHeartEyes}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: Row(
                            children: [
                              ToggleSwitch(
                                minHeight: 30,
                                minWidth: 50,
                                cornerRadius: 20.0,
                                activeBgColors: [
                                  const [kHighlightedTextColor],
                                  [Colors.red[900]!]
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: kNavigationIconColor,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: 1,
                                totalSwitches: 2,
                                labels: ['Yes', 'No'],
                                radiusStyle: true,
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Center(
                                  child: Text(
                                    "Show admin Only Properties",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: kHighlightedTextColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Text(
                          'Properties on Sale ${Emojis.buildingConstruction}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: kSubCategoryColor),
                        ),
                      ),
                      PropertiesOnSale(),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                        child: Text(
                          'Properties on Rent ${Emojis.moneyBag}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: kSubCategoryColor),
                        ),
                      ),
                      PropertiesOnRent(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
                child: Material(
                  color: kBottomNavigationBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  elevation: 3,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: kHighlightedTextColor,
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, BookmarkedPropertiesScreen.id);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.bookmark,
                              color: kNavigationIconColor,
                              size: 40,
                            ),
                          ),
                        ),
                        AvatarGlow(
                          glowColor: kHighlightedTextColor,
                          endRadius: 40,
                          duration: Duration(milliseconds: 2000),
                          repeat: true,
                          // showTwoGlows: true,
                          repeatPauseDuration: Duration(milliseconds: 200),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 188, 188, 188),
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.white,
                            ),
                            // radius: 40.0,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.navigation_rounded,
                            color: kNavigationIconColor,
                            size: 40,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.man_rounded,
                            color: kNavigationIconColor,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PropertiesOnRent extends StatelessWidget {
  const PropertiesOnRent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PropertyCard(imageloc: 'images/property1.jpg'),
          PropertyCard(imageloc: 'images/property2.jpg'),
          PropertyCard(imageloc: 'images/property3.jpg'),
        ],
      ),
    );
  }
}

class PropertiesOnSale extends StatelessWidget {
  const PropertiesOnSale({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PropertyCard(imageloc: 'images/property1.jpg'),
          PropertyCard(imageloc: 'images/property2.jpg'),
          PropertyCard(imageloc: 'images/property3.jpg'),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String imageloc;
  PropertyCard({required this.imageloc});
  @override
  void initState() {
    print(imageloc);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: kPropertyCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image(
                    width: 170,
                    fit: BoxFit.cover,
                    image: AssetImage(imageloc),
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
                  Text(
                    "\$128 ",
                    style: TextStyle(
                        fontSize: 18,
                        color: kHighlightedTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
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
                  SizedBox(
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PropertyDetailsScreen.id);
                      },
                      child: Text(
                        'View Details',
                        style: TextStyle(color: kPrimaryButtonColor),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CategoryCard(
      {required this.text_color,
      required this.btn_color,
      required this.text,
      required this.width});
  final Color btn_color;
  final Color text_color;
  final String text;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 45,
        width: width,
        // margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: kSecondaryButtonColor,
          ),
          color: btn_color,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: text_color, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
