import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:property_app/screens/addPopertiesScreen2.dart';
// import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
// import 'package:property_app/screens/addPropertiesScreen1.dart';
// import 'package:property_app/screens/propertyDetailsScreen.dart';
import 'package:property_app/main.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';
import '../components/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:property_app/currentUserInformation.dart';

late User loggedInUser;
bool displayAdminProperties = false;

class HomeScreen extends StatefulWidget {
  static const id = 'homeScreen1';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _firestore = FirebaseFirestore.instance;

class PropertiesOnSaleAdv extends StatelessWidget {
  List<PropertyCard> PropertiesOnSaleAll = [];
  List<PropertyCard> PropertiesOnSaleAdmin = [];
  List<PropertyCard> ApartmentOnSaleAdmin = [];
  List<PropertyCard> ApartmentOnSale = [];
  List<PropertyCard> PentHouseOnSaleAdmin = [];
  List<PropertyCard> PentHouseOnSale = [];
  List<PropertyCard> BuildingOnSaleAdmin = [];
  List<PropertyCard> BuildingOnSale = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("PropertiesSell").snapshots(),
      builder: (sontext, snapshot) {
        PropertiesOnSaleAll = [];
        PropertiesOnSaleAdmin = [];
        ApartmentOnSaleAdmin = [];
        ApartmentOnSale = [];
        PentHouseOnSaleAdmin = [];
        PentHouseOnSale = [];
        BuildingOnSaleAdmin = [];
        BuildingOnSale = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final properties = snapshot.data!.docs;
        for (var property in properties) {
          var isSet = property["isSetImages"].toString();
          if (isSet == "True") {
            try {
              List<String> propertyImages = [];
              for (int i = 1; i <= 10; i++) {
                if (property["imgUrl$i"] != "") {
                  propertyImages.add(property["imgUrl$i"]);
                }
              }
              // print(propertyImages);
              var imageloc = property["imgUrl1"];
              // print(imageloc);
              var price = property["Price"];
              var propertyAddress = property["PropertyAddress"];
              var propertyName = property["PropertyTitle"];
              var propertyDescription = property["PropertyDescription"];
              var to = "Sell";
              var bedRoom = property["BedRoom"];
              var BathRoom = property["BathRoom"];
              var propertyCategory = property["PropertyCategory"];
              var ownerName = property["OwnerName"];
              var propertyType = property["PropertyType"];
              var area = property["SquareFit"];

              final Property = PropertyCard(
                imageloc: imageloc,
                price: price,
                propertyAddress: propertyAddress,
                propertyName: propertyName,
                propertyImages: propertyImages,
                propertyCategory: propertyCategory,
                propertyDescription: propertyDescription,
                propertyType: propertyType,
                bedRoom: bedRoom,
                bathRoom: BathRoom,
                ownerName: ownerName,
                to: to,
                area: area,
              );
              PropertiesOnSaleAll.add(Property);
              if (ownerName.toString() == "john") {
                PropertiesOnSaleAdmin.add(Property);
              }
              if (propertyCategory.toString() == "Apartment") {
                ApartmentOnSale.add(Property);
                if (ownerName.toString() == "john") {
                  ApartmentOnSaleAdmin.add(Property);
                }
              }
              if (propertyCategory.toString() == "PentHouse") {
                PentHouseOnSale.add(Property);
                if (ownerName.toString() == "john") {
                  PentHouseOnSaleAdmin.add(Property);
                }
              }
              if (propertyCategory.toString() == "Building") {
                BuildingOnSale.add(Property);
                if (ownerName.toString() == "john") {
                  BuildingOnSaleAdmin.add(Property);
                }
              }
            } catch (e) {
              print(e);
            }
          }
        }
        // print("Propertes on Sale All:" + PropertiesOnSaleAll.toString());
        // print("Propertes on Sale Admin:" + PropertiesOnSaleAll.toString());
        // print("Apartments on Sale All:" + ApartmentOnSale.toString());
        // print("Apartments on Sale Admin:" + ApartmentOnSale.toString());
        // print("PentHouse on Sale All:" + ApartmentOnSale.toString());
        // print("PentHouse on Sale Admin:" + ApartmentOnSale.toString());
        // print("Building on Sale All:" + ApartmentOnSale.toString());
        // print("Building on Sale Admin:" + ApartmentOnSale.toString());
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          // shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: displayAdminProperties
              ? PropertiesOnSaleAdmin
              : PropertiesOnSaleAll,
        );
      },
    );
  }
}

class PropertiesOnRentAdv extends StatelessWidget {
  List<PropertyCard> PropertiesOnRentAll = [];
  List<PropertyCard> PropertiesOnRentAdmin = [];
  List<PropertyCard> ApartmentOnRentAdmin = [];
  List<PropertyCard> ApartmentOnRent = [];
  List<PropertyCard> PentHouseOnRentAdmin = [];
  List<PropertyCard> PentHouseOnRent = [];
  List<PropertyCard> BuildingOnRentAdmin = [];
  List<PropertyCard> BuildingOnRent = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("PropertiesRent").snapshots(),
      builder: (sontext, snapshot) {
        PropertiesOnRentAll = [];
        PropertiesOnRentAdmin = [];
        ApartmentOnRentAdmin = [];
        ApartmentOnRent = [];
        PentHouseOnRentAdmin = [];
        PentHouseOnRent = [];
        BuildingOnRentAdmin = [];
        BuildingOnRent = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final properties = snapshot.data!.docs;
        for (var property in properties) {
          var isSet = property["isSetImages"].toString();
          if (isSet == "True") {
            try {
              List<String> propertyImages = [];
              for (int i = 1; i <= 10; i++) {
                if (property["imgUrl$i"] != "") {
                  propertyImages.add(property["imgUrl$i"]);
                }
              }
              var imageloc = property["imgUrl1"];

              var price = property["Price"];
              var propertyAddress = property["PropertyAddress"];
              var propertyName = property["PropertyTitle"];
              var propertyDescription = property["PropertyDescription"];
              var to = "Rent";
              var bedRoom = property["BedRoom"];
              var BathRoom = property["BathRoom"];
              var propertyCategory = property["PropertyCategory"];
              var ownerName = property["OwnerName"];
              var propertyType = property["PropertyType"];
              var area = property["SquareFit"];

              final Property = PropertyCard(
                imageloc: imageloc,
                price: price,
                propertyAddress: propertyAddress,
                propertyName: propertyName,
                propertyImages: propertyImages,
                propertyCategory: propertyCategory,
                propertyDescription: propertyDescription,
                propertyType: propertyType,
                bedRoom: bedRoom,
                bathRoom: BathRoom,
                ownerName: ownerName,
                to: to,
                area: area,
              );
              PropertiesOnRentAll.add(Property);
              if (ownerName.toString() == "john") {
                PropertiesOnRentAdmin.add(Property);
              }
              if (propertyCategory.toString() == "Apartment") {
                ApartmentOnRent.add(Property);
                if (ownerName.toString() == "john") {
                  ApartmentOnRentAdmin.add(Property);
                }
              }
              if (propertyCategory.toString() == "PentHouse") {
                PentHouseOnRent.add(Property);
                if (ownerName.toString() == "john") {
                  PentHouseOnRentAdmin.add(Property);
                }
              }
              if (propertyCategory.toString() == "Building") {
                BuildingOnRent.add(Property);
                if (ownerName.toString() == "john") {
                  BuildingOnRentAdmin.add(Property);
                }
              }
            } catch (e) {
              print(e);
            }
          }
        }
        // print("Propertes on Rent All:" + PropertiesOnRentAll.toString());
        // print("Propertes on Rent Admin:" + PropertiesOnRentAll.toString());
        // print("Apartments on Rent All:" + ApartmentOnRent.toString());
        // print("Apartments on Rent Admin:" + ApartmentOnRent.toString());
        // print("PentHouse on Rent All:" + ApartmentOnRent.toString());
        // print("PentHouse on Rent Admin:" + ApartmentOnRent.toString());
        // print("Building on Rent All:" + ApartmentOnRent.toString());
        // print("Building on Rent Admin:" + ApartmentOnRent.toString());
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          // shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: displayAdminProperties
              ? PropertiesOnRentAdmin
              : PropertiesOnRentAll,
        );
      },
    );
  }
}

final customCacheManager = CacheManager(
  Config('customCacheKey',
      stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 100),
);

// late String name = "";

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  late AnimationController _animationController;

  late Animation _animation;

  late Color bookmarkIconColor;

  late IconData icn;
  // late String email = "";
  // late String mobileNumber = "";
  // late String addressLine1 = "";
  // late String addressLine2 = "";
  // late String password = "";
  // late String city = "";
  // late String state = "";
  // late String country = "";
  // late String postalCode = "";

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        userInfo.email = loggedInUser.email!;
        var currUserCollection = _firestore.collection("Users");
        var docSanpshot = await currUserCollection.doc(userInfo.email).get();

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
      }
    } catch (e) {
      print(e);
    }
  }

  void ToggleProperties(int index) {
    displayAdminProperties = index == 1 ? false : true;
    setState(() {
      // print(PropertiesOnRentAdmin);
      // print(PropertiesOnSaleAdmin);
    });
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
                          'Hey ${userInfo.name} ${Emojis.wavingHandLightSkinTone}',
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
                      text: 'PentHouse',
                      width: 90,
                      text_color: kSubCategoryColor,
                    ),
                    CategoryCard(
                      btn_color: kSecondaryButtonColor,
                      text: 'Building',
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
                            ),
                            Spacer(),
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
                                // print('switched to: $index');

                                // print("Show Admin properties");

                                print(displayAdminProperties);
                                ToggleProperties(index!);
                              },
                            ),
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
                      SizedBox(
                        height: 415,
                        // child: ListView(
                        //   padding: EdgeInsets.symmetric(vertical: 10),
                        //   // shrinkWrap: true,
                        //   physics: BouncingScrollPhysics(),
                        //   scrollDirection: Axis.horizontal,
                        //   children: Properties,
                        // ),
                        child: PropertiesOnSaleAdv(),
                      ),
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
                      SizedBox(
                        height: 415,
                        // child: ListView(
                        //   padding: EdgeInsets.symmetric(vertical: 10),
                        //   shrinkWrap: true,
                        //   physics: BouncingScrollPhysics(),
                        //   scrollDirection: Axis.horizontal,
                        //   // children: Properties,
                        // ),
                        child: PropertiesOnRentAdv(),
                      ),
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

class PropertyCard extends StatefulWidget {
  final String imageloc;
  final String propertyName;
  final String propertyAddress;
  final String price;
  final String propertyDescription;
  final String to;
  final String ownerName;
  final String propertyType;
  final String bedRoom;
  final String bathRoom;
  final String propertyCategory;
  final String area;
  final List<String> propertyImages;
  const PropertyCard(
      {required this.imageloc,
      required this.price,
      required this.propertyAddress,
      required this.propertyName,
      required this.bathRoom,
      required this.bedRoom,
      required this.ownerName,
      required this.propertyCategory,
      required this.propertyDescription,
      required this.propertyType,
      required this.to,
      required this.propertyImages,
      required this.area});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late bool bookedmark = false;

  // String propertyName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 190,
        height: 230,
        decoration: const BoxDecoration(
          color: kPropertyCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 8.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      cacheManager: customCacheManager,
                      key: UniqueKey(),
                      imageUrl: widget.imageloc,
                      height: 230,
                      width: 190,
                      // maxHeightDiskCache: 230,
                      // maxWidthDiskCache: 190,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: kHighlightedTextColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black12,
                        child: Icon(
                          Icons.error,
                          color: kHighlightedTextColor,
                        ),
                      ),
                    )),
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
                    widget.price + "\$",
                    style: TextStyle(
                        fontSize: 18,
                        color: kHighlightedTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.to == "Rent" ? " / Month" : "",
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
                      // Navigator.pushNamed(context, PropertyDetailsScreen.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailsScreen(
                              propertyAddress: widget.propertyAddress,
                              propertyTitle: widget.propertyName,
                              to: widget.to,
                              ownerName: widget.ownerName,
                              propertyDescription: widget.propertyDescription,
                              noBathroom: widget.bathRoom,
                              noBedroom: widget.bedRoom,
                              area: widget.area,
                              propertyImages: widget.propertyImages,
                              price: widget.price),
                        ),
                      );
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
