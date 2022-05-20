import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/myPropertiesScreen.dart';
// import 'package:property_app/screens/loginScreen.dart';
import '../constants.dart';
import 'dart:math';
import '../components/bottomNavigationBar.dart';
import '../components/dialogBoxListWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_app/currentUserInformation.dart';
import 'package:property_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../screens/registerScreen.dart';
import 'package:property_app/screens/searchScreen.dart';
import '../screens/loginScreen.dart';

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

List<String> option_titles = [
  "Personal Information",
  "Email",
  // "Phone",
  "Password",
  "Address",
];

final _firestore = FirebaseFirestore.instance;

class _profileScreenState extends State<profileScreen> {
  late int flex_by = 2;
  late String page = profileScreen.id;
  final meaageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    // print("Hi");
    getCurrentUser();
    super.initState();
  }

  void updateVisibility(bool isHidden) {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void getCurrentUser() async {
    try {
      var currUserCollection = _firestore.collection("Users");
      var docSanpshot =
          await currUserCollection.doc(_auth.currentUser!.email).get();

      if (docSanpshot.exists) {
        Map<String, dynamic>? data = docSanpshot.data();
        setState(
          () {
            userInfo.name = data?['name'];
            userInfo.mobileNumber = data?['number'];
            print(userInfo.name);
            print(userInfo.mobileNumber);
          },
        );
      }
      print(userInfo.email);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    physics:
    const BouncingScrollPhysics();
    double width = MediaQuery.of(context).size.width;

    print(width);

    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Opacity(
                      opacity: 0.80,
                      child: Image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 215,
                        image:
                            AssetImage('images/profileBackgroundImage11.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 155,

                    left: (width / 2) - 53,

                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundColor: kPageBackgroundColor,
                      radius: 53,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('images/profile_img1.jpg'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        userInfo.name,
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            wordSpacing: -1),
                      ),
                      Text(
                        userInfo.email,
                        style: TextStyle(
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await FirebaseAuth.instance.signOut();
                          await prefs.clear();
                          Navigator.pushNamed(context, loginScreen.id);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: kPrimaryButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.account_circle_outlined,
                      Title: "Personal Information",
                      SubTitle: userInfo.name,
                    ),
                    // ProfileDetailsContainer(
                    //   icon: Icons.call_outlined,
                    //   Title: "Phone",
                    //   SubTitle: userInfo.mobileNumber,
                    // ),
                    ProfileDetailsContainer(
                      icon: Icons.call_outlined,
                      Title: "Email",
                      SubTitle: userInfo.email,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.lock_outlined,
                      Title: "Password",
                      SubTitle: "",
                      // SubTitle: userInfo.password,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.add_location_outlined,
                      Title: "Address",
                      SubTitle: "Residential Address",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.house,
                      Title: "My Properties",
                      SubTitle: "",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            // BottomPageNavigationBar(
            //   flex_by: 2,
            //   page: profileScreen.id,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Expanded(
          flex: 1,
          child: Container(
            color: kPageBackgroundColor,
            height: 70,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
              child: Material(
                elevation: 3,
                color: kBottomNavigationBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
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
        ),
      ),
    );
  }
}

class ProfileDetailsContainer extends StatefulWidget {
  final IconData icon;
  final String Title;
  final String SubTitle;

  ProfileDetailsContainer(
      {required this.icon, required this.Title, required this.SubTitle});

  @override
  State<ProfileDetailsContainer> createState() =>
      _ProfileDetailsContainerState();
}

class _ProfileDetailsContainerState extends State<ProfileDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          color: kPropertyCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 70,
        // color: kSecondaryButtonColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: kPageBackgroundColor,
                child: Icon(
                  widget.icon,
                  size: 32,
                  color: kNavigationIconColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.Title,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.SubTitle,
                    style: TextStyle(
                        color: kBottomNavigationBackgroundColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    widget.Title == "My Properties"
                        ? Navigator.pushNamed(context, myPropertiesScreen.id)
                        : showDialog(
                            context: context,
                            builder: (_) => editDetailsPopup(widget.Title,
                                fields[option_titles.indexOf(widget.Title)]));
                    setState(() {
                      // Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.expand_less_rounded,
                    color: kNavigationIconColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SimpleDialog editDetailsPopup(String boxTitle, List<Widget> childern) {
    final _auth = FirebaseAuth.instance;
    return SimpleDialog(
      backgroundColor: kPageBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        boxTitle,
        style: TextStyle(
          color: kHighlightedTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Column(children: childern),
                ElevatedButton(
                  onPressed: () async {
                    _firestore
                        .collection("Users")
                        .doc(_auth.currentUser!.email)
                        .update({
                      "email": userInfo.email,
                      "name": userInfo.name,
                      "number": userInfo.mobileNumber,
                      "addressLine1": userInfo.addressLine1,
                      "addressLine2": userInfo.addressLine2,
                      "city": userInfo.city,
                      "state": userInfo.state,
                      "country": userInfo.country,
                      "postalcode": userInfo.postalCode,
                    });
                    Navigator.pop(context);
                    setState(() {
                      try {
                        if (passwordKey.currentState!.validate()) {}
                        print(userInfo.password);
                        userInfo.name = userInfo.name;
                        if (newPassword == confirmNewPassword) {
                          var loggedInUser = _auth.currentUser;
                          loggedInUser
                              ?.updatePassword(userInfo.password)
                              .then((_) {
                            userInfo.password = newPassword;
                            print(userInfo.password);
                            print("Successfully changed password");
                          }).catchError((error) {
                            print(
                                "Password can't be changed" + error.toString());
                          });
                        } else {
                          print("Reconfirm New Password");
                        }
                        print("Process data");
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
