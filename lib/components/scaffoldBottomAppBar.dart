import 'package:flutter/material.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/myPropertiesScreen.dart';
import 'package:property_app/screens/searchScreen.dart';
import '../constants.dart';
import '../screens/homescreen.dart';
import '../screens/profileScreen.dart';
import '../screens/addPropertiesScreen1.dart';
import 'package:avatar_glow/avatar_glow.dart';

class scaffoldBottomAppBar extends StatelessWidget {
  const scaffoldBottomAppBar({
    Key? key,
    required this.page,
    required this.flex_by,
  }) : super(key: key);

  final int flex_by;
  final String page;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: kPageBackgroundColor,
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
          child: Material(
            color: kBottomNavigationBackgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page != HomeScreen.id) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    // backgroundColor: kBottomNavigationBackgroundColor,
                    backgroundColor: page == HomeScreen.id
                        ? kHighlightedTextColor
                        : kBottomNavigationBackgroundColor,
                    child: Icon(
                      Icons.home,
                      // color: kNavigationIconColo"r,
                      color: page == HomeScreen.id
                          ? Colors.white
                          : kNavigationIconColor,
                      size: 40,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (page != BookmarkedPropertiesScreen.id) {
                      Navigator.pushNamed(
                          context, BookmarkedPropertiesScreen.id);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: page == BookmarkedPropertiesScreen.id
                        ? kHighlightedTextColor
                        : kBottomNavigationBackgroundColor,
                    child: Icon(
                      Icons.bookmark,
                      color: page == BookmarkedPropertiesScreen.id
                          ? Colors.white
                          : kNavigationIconColor,
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (page != AddPropertiesScreen.id) {
                      Navigator.pushNamed(context, AddPropertiesScreen.id);
                    }
                  },
                  child: const AvatarGlow(
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
                ),
                GestureDetector(
                  onTap: () {
                    if (page != searchScreen.id) {
                      Navigator.pushNamed(context, searchScreen.id);
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: page == searchScreen.id
                        ? kHighlightedTextColor
                        : kBottomNavigationBackgroundColor,
                    child: Icon(
                      Icons.search_sharp,
                      color: page == searchScreen.id
                          ? Colors.white
                          : kNavigationIconColor,
                      size: 45,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (page != profileScreen.id) {
                      Navigator.pushNamed(context, profileScreen.id);
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: page == profileScreen.id ||
                            myPropertiesScreen.id == page
                        ? kHighlightedTextColor
                        : kBottomNavigationBackgroundColor,
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: page == profileScreen.id
                          ? Colors.white
                          : kNavigationIconColor,
                      size: 45,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}