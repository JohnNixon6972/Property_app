import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
// import 'package:property_app/screens/addPropertiesScreen1.dart';
// import 'package:property_app/screens/propertyDetailsScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';
import '../components/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  late AnimationController _animationController;

  late Animation _animation;

  late Color bookmarkIconColor;

  late IconData icn;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  late String name = "";
  late String email = "";
  late String mobileNumber = "";
  late String addressLine1 = "";
  late String addressLine2 = "";
  late String password = "";
  late String city = "";
  late String state = "";
  late String country = "";
  late String postalCode = "";

  @override
  void initState() {
    getCurrentUser();
  }

  void buildStream() async {

    _

    StreamBuilder(
      // stream: FirebaseFirestore.instance
      //     .collection()
      //     .doc()
      //     .snapshots(),
      // builder: (context, snapshot) {
      //   return !snapshot.hasData
      //       ? Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : Container(
      //           child: ListView.builder(itemCount: snapshot.data,itemBuilder: itemBuilder),
      //         );
      // },
    );
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        email = loggedInUser.email!;
        var currUserCollection = _firestore.collection("Users");
        var docSanpshot = await currUserCollection.doc(email).get();

        if (docSanpshot.exists) {
          Map<String, dynamic>? data = docSanpshot.data();
          setState(
            () {
              name = data?['name'];
              mobileNumber = data?['number'];
              print(name);
              print(mobileNumber);
            },
          );
        }
        print(email);
      }
    } catch (e) {
      print(e);
    }
  }

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
                      children: [
                        Text(
                          'Hey $name ${Emojis.wavingHandLightSkinTone}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kBottomNavigationBackgroundColor,
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
                      Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            ToggleSwitch(
                              minHeight: 30,
                              minWidth: 50,
                              cornerRadius: 20.0,
                              activeBgColors: [
                                const [Color.fromARGB(255, 9, 70, 32)],
                                [kHighlightedTextColor]
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
                        color: kHighlightedTextColor,
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
            BottomPageNavigationBar(
              flex_by: 4,
              page: HomeScreen.id,
            ),
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
      height: 400,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          // PropertyCard(imageloc: 'images/property1.jpg',propertyName: "John",),
          // PropertyCard(imageloc: 'images/property2.jpg'),
          // PropertyCard(imageloc: 'images/property3.jpg'),
        ],
      ),
    );
    // return ListView.builder(itemBuilder: itemBuilder)
  }
}

class PropertiesOnSale extends StatelessWidget {
  const PropertiesOnSale({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          // PropertyCard(imageloc: 'images/property1.jpg'),
          // PropertyCard(imageloc: 'images/property2.jpg'),
          // PropertyCard(imageloc: 'images/property3.jpg'),
        ],
      ),
    );
  }
}

class PropertyCard extends StatefulWidget {
  final String imageloc;
  final String propertyName;
  final String propertyAddress;
  final String price;
  const PropertyCard(
      {required this.imageloc,
      required this.price,
      required this.propertyAddress,
      required this.propertyName});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late bool bookedmark = false;

  // String propertyName;
  @override
  void initState() {
    print(widget.imageloc);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 180,
        decoration: const BoxDecoration(
          // border: Border.all(
          //   color: kBottomNavigationBackgroundColor,
          // ),
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
                    image: AssetImage(widget.imageloc),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.propertyName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.propertyAddress,
                  style: TextStyle(
                    color: kSubCategoryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.price,
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
                          : kHighlightedTextColor,
                    ),
                  ),
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
