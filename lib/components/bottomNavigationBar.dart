import 'package:flutter/material.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import '../constants.dart';
import '../screens/homescreen.dart';
import '../screens/profileScreen.dart';
import '../screens/propertyDetailsScreen.dart';
import 'package:avatar_glow/avatar_glow.dart';

class BottomPageNavigationBar extends StatelessWidget {
  final int flex_by;
  final String page;

  BottomPageNavigationBar({required this.flex_by, required this.page});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex_by,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HomeScreen.id);
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
                    Navigator.pushNamed(context, BookmarkedPropertiesScreen.id);
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
                    // Navigator.pushNamed(context, )
                  },
                  child: AvatarGlow(
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
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.navigation_rounded,
                      color: kNavigationIconColor,
                      size: 40,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, profileScreen.id);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: page == profileScreen.id
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
