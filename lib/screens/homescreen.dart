import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:property_app/components/scaffoldBottomAppBar.dart';
import 'package:property_app/screens/aboutUs.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
import 'package:property_app/main.dart';
import '../constants.dart';
// import '../components/bottomNavigationBar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'aboutUs.dart';

late User loggedInUser;
bool displayAdminProperties = false;
List<String> bookmarkedPropertyNames = [];
List<String> myPropertiesAdv = [];

class HomeScreen extends StatefulWidget {
  static const id = 'homeScreen1';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _firestore = FirebaseFirestore.instance;

class PropertiesOnSaleAdv extends StatefulWidget {
  @override
  State<PropertiesOnSaleAdv> createState() => _PropertiesOnSaleAdvState();
}

List<PropertyCard> PropertiesOnSaleAll = [];
List<PropertyCard> approvedProperties = [];
List<PropertyCard> unApprovedProperties = [];
List<String> approvedPropertiesNames = [];
List<String> unApprovedPropertiesNames = [];

class _PropertiesOnSaleAdvState extends State<PropertiesOnSaleAdv> {
  List<PropertyCard> PropertiesOnSaleAdmin = [];

  List<PropertyCard> ApartmentOnSaleAdmin = [];

  List<PropertyCard> ApartmentOnSale = [];

  List<PropertyCard> HouseOnSaleAdmin = [];

  List<PropertyCard> HouseOnSale = [];

  List<PropertyCard> PlotOnSale = [];

  List<PropertyCard> PlotOnSaleAdmin = [];

  List<PropertyCard> LandOnSale = [];

  List<PropertyCard> LandOnSaleAdmin = [];

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
        HouseOnSaleAdmin = [];
        HouseOnSale = [];
        LandOnSale = [];
        LandOnSaleAdmin = [];
        PlotOnSale = [];
        PlotOnSaleAdmin = [];
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
          var isApproved = property["isApproved"].toString();

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
              var to = property["PropertyTo"];
              var bedRoom = property["BedRoom"];
              var BathRoom = property["BathRoom"];
              var propertyCategory = property["PropertyCategory"];
              var ownerName = property["OwnerName"];
              var propertyType = property["PropertyType"];
              var area = property["PlotArea"];
              var constructionArea = property["ConstructionArea"];
              var ownerEmail = property["PropertyBy"];
              var ownerPhno = property["PhNo"];
              var facing = property["PropertyDirection"];
              var lenght = property["LandLength"];
              var width = property["LandWidth"];
              var ownerImgUrl = property["profileImgUrl"];
              var cent = property["Cent"];
              var district = property["District"];
              var state = property["State"];
              var city = property["City"];
              var taluk = property["Taluk"];
              var dtcpApproved = property["DTCPApproved"];
              dtcpApproved = dtcpApproved == "false" ? false : true;

              final Property = PropertyCard(
                dtcpApproved: dtcpApproved,
                city: city,
                taluk: taluk,
                state: state,
                district: district,
                ownerMail: ownerEmail,
                ownerPhoneNo: ownerPhno,
                constructionArea: constructionArea,
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
                lenght: lenght,
                width: width,
                direction: facing,
                ownerImgUrl: ownerImgUrl,
                cent: cent,
              );
              if (isApproved == "True") {
                PropertiesOnSaleAll.add(Property);
                if (!approvedPropertiesNames.contains(Property.propertyName)) {
                  approvedPropertiesNames.add(Property.propertyName);
                  approvedProperties.add(Property);
                }
                // print(propertyName);
                // if (bookmarkedPropertyNames.contains(propertyName.toString())) {
                //   bookmarkedProperties.add(Property);
                // }
                if (ownerPhno.toString() == userInfo.mobileNumber &&
                    !myPropertiesAdv.contains(Property.propertyName)) {
                  print(Property.propertyName);
                  myPropertiesAdv.add(Property.propertyName);
                }
                if (ownerName.toString() == "john") {
                  PropertiesOnSaleAdmin.add(Property);
                }
                if (propertyCategory.toString() == "Apartment") {
                  ApartmentOnSale.add(Property);
                  if (ownerName.toString() == "john") {
                    ApartmentOnSaleAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "House") {
                  HouseOnSale.add(Property);
                  if (ownerName.toString() == "john") {
                    HouseOnSaleAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Plot") {
                  PlotOnSale.add(Property);
                  if (ownerName.toString() == "john") {
                    PlotOnSaleAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Land") {
                  LandOnSale.add(Property);
                  if (ownerName.toString() == "john") {
                    LandOnSaleAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Building") {
                  BuildingOnSale.add(Property);
                  if (ownerName.toString() == "john") {
                    BuildingOnSaleAdmin.add(Property);
                  }
                }
              } else {
                if (!unApprovedPropertiesNames
                    .contains(Property.propertyName)) {
                  unApprovedPropertiesNames.add(Property.propertyName);
                  unApprovedProperties.add(Property);
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
        List<PropertyCard> displaySaleProperties = [];
        if (displayAdminProperties) {
          if (categorySelected == "Appartment") {
            displaySaleProperties = ApartmentOnSaleAdmin;
          } else if (categorySelected == "House") {
            displaySaleProperties = HouseOnSaleAdmin;
          } else if (categorySelected == "Plot") {
            displaySaleProperties = PlotOnSaleAdmin;
          } else if (categorySelected == "Land") {
            displaySaleProperties = LandOnSaleAdmin;
          } else if (categorySelected == "Building") {
            displaySaleProperties = BuildingOnSaleAdmin;
          } else {
            displaySaleProperties = PropertiesOnSaleAdmin;
          }
        } else {
          if (categorySelected == "Appartment") {
            displaySaleProperties = ApartmentOnSale;
          } else if (categorySelected == "House") {
            displaySaleProperties = HouseOnSale;
          } else if (categorySelected == "Plot") {
            displaySaleProperties = PlotOnSale;
          } else if (categorySelected == "Land") {
            displaySaleProperties = LandOnSale;
          } else if (categorySelected == "Building") {
            displaySaleProperties = BuildingOnSale;
          } else {
            displaySaleProperties = PropertiesOnSaleAll;
          }
        }
        // print(displaySaleProperties);
        return AnimationLimiter(
          child: ListView(
            // reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 10),
            // shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (widget) => SlideAnimation(
                    duration: const Duration(seconds: 3),
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                        duration: const Duration(seconds: 3), child: widget)),
                children: displaySaleProperties),
            // children: displaySaleProperties),
          ),
        );
      },
    );
  }
}

class PropertiesOnRentAdv extends StatefulWidget {
  @override
  State<PropertiesOnRentAdv> createState() => _PropertiesOnRentAdvState();
}

List<PropertyCard> PropertiesOnRentAll = [];

class _PropertiesOnRentAdvState extends State<PropertiesOnRentAdv> {
  List<PropertyCard> PropertiesOnRentAdmin = [];

  List<PropertyCard> ApartmentOnRentAdmin = [];

  List<PropertyCard> ApartmentOnRent = [];

  List<PropertyCard> HouseOnRentAdmin = [];

  List<PropertyCard> HouseOnRent = [];

  List<PropertyCard> LandOnRentAdmin = [];

  List<PropertyCard> LandOnRent = [];

  List<PropertyCard> PlotOnRentAdmin = [];

  List<PropertyCard> PlotOnRent = [];

  List<PropertyCard> BuildingOnRentAdmin = [];

  List<PropertyCard> BuildingOnRent = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("PropertiesRent").snapshots(),
      builder: (context, snapshot) {
        PropertiesOnRentAll = [];
        PropertiesOnRentAdmin = [];
        ApartmentOnRentAdmin = [];
        ApartmentOnRent = [];
        HouseOnRentAdmin = [];
        HouseOnRent = [];
        LandOnRentAdmin = [];
        LandOnRent = [];
        PlotOnRentAdmin = [];
        PlotOnRent = [];
        BuildingOnRentAdmin = [];
        BuildingOnRent = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final properties = snapshot.data!.docs;
        for (var property in properties) {
          var isSet = property["isSetImages"].toString();
          var isApproved = property["isApproved"].toString();
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
              var to = property["PropertyTo"];
              var bedRoom = property["BedRoom"];
              var BathRoom = property["BathRoom"];
              var propertyCategory = property["PropertyCategory"];
              var ownerName = property["OwnerName"];
              var propertyType = property["PropertyType"];
              var area = property["PlotArea"];
              var constructionArea = property["ConstructionArea"];
              var ownerEmail = property["PropertyBy"];
              var ownerPhno = property["PhNo"];
              var facing = property["PropertyDirection"];
              var lenght = property["LandLength"];
              var width = property["LandWidth"];
              var ownerImgUrl = property["profileImgUrl"];
              var cent = property["Cent"];
              var district = property["District"];
              var state = property["State"];
              var city = property["City"];
              var taluk = property["Taluk"];
              var dtcpApproved = property["DTCPApproved"];
              dtcpApproved = dtcpApproved == "false" ? false : true;

              final Property = PropertyCard(
                dtcpApproved: dtcpApproved,
                city: city,
                taluk: taluk,
                state: state,
                district: district,
                ownerMail: ownerEmail,
                constructionArea: constructionArea,
                ownerPhoneNo: ownerPhno,
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
                lenght: lenght,
                width: width,
                direction: facing,
                ownerImgUrl: ownerImgUrl,
                cent: cent,
              );

              if (isApproved == "True") {
                PropertiesOnRentAll.add(Property);
                if (!approvedPropertiesNames.contains(Property.propertyName)) {
                  approvedPropertiesNames.add(Property.propertyName);
                  approvedProperties.add(Property);
                }
                if (ownerPhno.toString() == userInfo.mobileNumber &&
                    !myPropertiesAdv.contains(Property.propertyName)) {
                  myPropertiesAdv.add(Property.propertyName);
                }
                if (ownerName.toString() == "john") {
                  PropertiesOnRentAdmin.add(Property);
                }

                if (propertyCategory.toString() == "Apartment") {
                  ApartmentOnRent.add(Property);
                  if (ownerName.toString() == "john") {
                    ApartmentOnRentAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "House") {
                  HouseOnRent.add(Property);
                  if (ownerName.toString() == "john") {
                    HouseOnRentAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Plot") {
                  PlotOnRent.add(Property);
                  if (ownerName.toString() == "john") {
                    PlotOnRentAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Land") {
                  LandOnRent.add(Property);
                  if (ownerName.toString() == "john") {
                    LandOnRentAdmin.add(Property);
                  }
                }
                if (propertyCategory.toString() == "Building") {
                  BuildingOnRent.add(Property);
                  if (ownerName.toString() == "john") {
                    BuildingOnRentAdmin.add(Property);
                  }
                }
              } else {
                if (!unApprovedPropertiesNames
                    .contains(Property.propertyName)) {
                  unApprovedPropertiesNames.add(Property.propertyName);
                  unApprovedProperties.add(Property);
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
        List<PropertyCard> displayRentProperties = [];
        if (displayAdminProperties) {
          if (categorySelected == "Appartment") {
            displayRentProperties = ApartmentOnRentAdmin;
          } else if (categorySelected == "House") {
            displayRentProperties = HouseOnRentAdmin;
          } else if (categorySelected == "Plot") {
            displayRentProperties = PlotOnRentAdmin;
          } else if (categorySelected == "Land") {
            displayRentProperties = LandOnRentAdmin;
          } else if (categorySelected == "Building") {
            displayRentProperties = BuildingOnRentAdmin;
          } else {
            displayRentProperties = PropertiesOnRentAdmin;
          }
        } else {
          if (categorySelected == "Appartment") {
            displayRentProperties = ApartmentOnRent;
          } else if (categorySelected == "House") {
            displayRentProperties = HouseOnRent;
          } else if (categorySelected == "Land") {
            displayRentProperties = LandOnRent;
          } else if (categorySelected == "Plot") {
            displayRentProperties = PlotOnRent;
          } else if (categorySelected == "Building") {
            displayRentProperties = BuildingOnRent;
          } else {
            displayRentProperties = PropertiesOnRentAll;
          }
        }

        return AnimationLimiter(
          child: ListView(
            // reverse: true
            children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (widget) => SlideAnimation(
                      duration: const Duration(seconds: 3),
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        duration: const Duration(seconds: 3),
                        child: widget,
                      ),
                    ),
                children: displayRentProperties),
            padding: const EdgeInsets.symmetric(vertical: 10),
            // shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            // children: displayRentProperties
          ),
        );
      },
    );
  }
}

Future<void> getBookMarkedProperties() async {
  // print(userInfo.email);
  // print("Hi");

  final db = FirebaseFirestore.instance;
  var result = await db
      .collection('Users')
      .doc(userInfo.mobileNumber)
      .collection("BookMarkedProperties")
      .get();
  for (var res in result.docs) {
    if (!bookmarkedPropertyNames.contains(res.id.toString())) {
      bookmarkedPropertyNames.add(res.id.toString());
    }
  }
  print(bookmarkedPropertyNames);
}

final customCacheManager = CacheManager(
  Config('customCacheKey',
      stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 100),
);

// late String name = "";
String categorySelected = "All";

class _HomeScreenState extends State<HomeScreen> {
  late List<bool> isSelected;
  @override
  void initState() {
    isSelected = [true, false];
    getBookMarkedProperties();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  late AnimationController _animationController;

  late Animation _animation;

  late Color bookmarkIconColor;

  late IconData icn;

  Color SelectedToggleBottonColor = kNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to leave')),
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
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: kBottomNavigationBackgroundColor,
                            ),
                          ),
                          const Text(
                            "Let's find your best residence!",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, profileScreen.id);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: userInfo.profileImgUrl == ""
                            ? const Image(
                                height: 70,
                                width: 70,
                                image: AssetImage('images/profile_img9.png'))
                            : CachedNetworkImage(
                                cacheManager: customCacheManager,
                                key: UniqueKey(),
                                imageUrl: userInfo.profileImgUrl,
                                height: 70,
                                width: 70,
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
                                  child: const Icon(
                                    Icons.error,
                                    color: kHighlightedTextColor,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(
                  children: [
                    const Text(
                      'Category',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, aboutUs.id);
                      },
                      child: const Icon(
                        Icons.people,
                        color: kHighlightedTextColor,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "All";
                          });
                        },
                        btn_color: categorySelected == "All"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'All',
                        width: 60,
                        text_color: categorySelected == "All"
                            ? Colors.white
                            : kSubCategoryColor,
                      ),
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "Plot";
                          });
                        },
                        btn_color: categorySelected == "Plot"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'Plot',
                        width: 80,
                        text_color: categorySelected == "Plot"
                            ? Colors.white
                            : kSubCategoryColor,
                      ),
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "Land";
                          });
                        },
                        btn_color: categorySelected == "Land"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'Land',
                        width: 80,
                        text_color: categorySelected == "Land"
                            ? Colors.white
                            : kSubCategoryColor,
                      ),
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "House";
                          });
                        },
                        btn_color: categorySelected == "House"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'House',
                        width: 80,
                        text_color: categorySelected == "House"
                            ? Colors.white
                            : kSubCategoryColor,
                      ),
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "Building";
                          });
                        },
                        btn_color: categorySelected == "Building"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'Building',
                        width: 90,
                        text_color: categorySelected == "Building"
                            ? Colors.white
                            : kSubCategoryColor,
                      ),
                      CategoryCard(
                        onTap: () {
                          setState(() {
                            categorySelected = "Appartment";
                          });
                        },
                        btn_color: categorySelected == "Appartment"
                            ? kPrimaryButtonColor
                            : kSecondaryButtonColor,
                        text: 'Appartment',
                        width: 90,
                        text_color: categorySelected == "Appartment"
                            ? Colors.white
                            : kSubCategoryColor,
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
                          padding:
                              EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Text(
                            'Best for you ${Emojis.smilingFaceWithHeartEyes}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Center(
                                  child: Text(
                                    "Show admin Only Properties",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: kHighlightedTextColor),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ToggleButtons(
                                constraints: const BoxConstraints(minHeight: 8),
                                fillColor: SelectedToggleBottonColor,
                                // disabledColor: Colors.green,
                                // focusColor: Colors.green,

                                borderWidth: 2,
                                selectedColor: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    if (index == 0) {
                                      SelectedToggleBottonColor = kNo;
                                    } else if (index == 1) {
                                      SelectedToggleBottonColor = kYes;
                                    }

                                    displayAdminProperties =
                                        index != 0 ? true : false;
                                    print(displayAdminProperties);
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
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
                          child: PropertiesOnSaleAdv(),
                        ),
                        const Divider(
                          thickness: 1,
                          color: kHighlightedTextColor,
                        ),
                        const Padding(
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
                          child: PropertiesOnRentAdv(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // BottomPageNavigationBar(
              //   flex_by: 4,
              //   page: HomeScreen.id,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const scaffoldBottomAppBar(
        flex_by: 2,
        page: HomeScreen.id,
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
  final String ownerMail;
  final String ownerPhoneNo;
  final String lenght;
  final String width;
  final String direction;
  final String constructionArea;
  final String ownerImgUrl;
  final String cent;
  final String district;
  final String taluk;
  final String city;
  final String state;
  final bool dtcpApproved;
  final List<String> propertyImages;
  const PropertyCard(
      {required this.imageloc,
      required this.dtcpApproved,
      required this.taluk,
      required this.city,
      required this.constructionArea,
      required this.ownerMail,
      required this.ownerPhoneNo,
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
      required this.area,
      required this.direction,
      required this.lenght,
      required this.ownerImgUrl,
      required this.cent,
      required this.state,
      required this.district,
      required this.width});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late bool bookedmark = bookmarkedPropertyNames.contains(widget.propertyName);

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
                      child: const Icon(
                        Icons.error,
                        color: kHighlightedTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.propertyName,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.propertyAddress,
                  style: const TextStyle(
                    color: kSubCategoryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "\u{20B9} " +
                        widget.price
                            .replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},")
                            .toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: kHighlightedTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.to == "Rent" ? " / Month" : "",
                    style: const TextStyle(
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
                            dtcpApproved: widget.dtcpApproved,
                            taluk: widget.taluk,
                            city: widget.city,
                            state: widget.state,
                            district: widget.district,
                            ownerMail: widget.ownerMail,
                            ownerPhoneNo: widget.ownerPhoneNo,
                            type: widget.propertyType,
                            category: widget.propertyCategory,
                            propertyAddress: widget.propertyAddress,
                            propertyTitle: widget.propertyName,
                            to: widget.to,
                            ownerName: widget.ownerName,
                            propertyDescription: widget.propertyDescription,
                            noBathroom: widget.bathRoom,
                            noBedroom: widget.bedRoom,
                            area: widget.area,
                            propertyImages: widget.propertyImages,
                            price: widget.price,
                            lenght: widget.lenght,
                            width: widget.width,
                            constructionArea: widget.constructionArea,
                            ownerImgUrl: widget.ownerImgUrl,
                            cent: widget.cent,
                            face: widget.direction,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: kPrimaryButtonColor),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        bookedmark = !bookedmark;
                        if (bookedmark) {
                          _firestore
                              .collection("Users")
                              .doc(userInfo.mobileNumber)
                              .collection("BookMarkedProperties")
                              .doc(widget.propertyName)
                              .set({"PropertyName": widget.propertyName});
                          // print("Bookmarked ${widget.propertyName}");
                          bookmarkedPropertyNames.add(widget.propertyName);
                        } else {
                          _firestore
                              .collection("Users")
                              .doc(userInfo.mobileNumber)
                              .collection("BookMarkedProperties")
                              .doc(widget.propertyName)
                              .delete();
                          bookmarkedPropertyNames.remove(widget.propertyName);
                        }
                      });
                    },
                    icon: Icon(
                      bookmarkedPropertyNames.contains(widget.propertyName)
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color:
                          bookmarkedPropertyNames.contains(widget.propertyName)
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
      required this.width,
      required this.onTap});
  final Color btn_color;
  final Color text_color;
  final String text;
  final double width;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: GestureDetector(
          onTap: onTap,
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
                style:
                    TextStyle(color: text_color, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
