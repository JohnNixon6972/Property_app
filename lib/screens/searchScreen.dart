import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/scaffoldBottomAppBar.dart';
import 'package:property_app/constants.dart';

import 'package:property_app/screens/propertyDetailsScreen.dart';

import './homescreen.dart';

final myController = TextEditingController();

class searchScreen extends StatefulWidget {
  static const String id = 'searchScreen';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late List<bool> isSelected;
  String query = "";
  String searchType = "PropertiesRent";
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
    myController.addListener(() {
      // print("myController.text = ${myController.text}");
    });
  }

  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection(searchType).snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: kHighlightedTextColor,
              ),
            );
          } else if (query == "") {
            return Container();
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['PropertyAddress']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 430),
                child: Center(
                  child: Text(
                    "No Such Place For Property Found!",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: kHighlightedTextColor),
                  ),
                ),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['PropertyAddress']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> property) {
                    var isSet = property["isSetImages"].toString();

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
                    var ownerPhno = property["PhNo"];
                    var ownerMail = property["PropertyBy"];
                    var propertyType = property["PropertyType"];
                    var area = property["PlotArea"];
                    var lenght = property["LandLength"];
                    var width = property["LandWidth"];
                    var constructionArea = property["ConstructionArea"];
                    var ownerImgUrl = property["profileImgUrl"];
                    var cent = property["Cent"];
                    var face = property["PropertyDirection"];

                    return SearchedProperties(
                      ownerMail: ownerMail,
                      ownerPhno: ownerPhno,
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
                      constructionArea: constructionArea,
                      ownerImgUrl: ownerImgUrl,
                      cent: cent,
                      face: face,
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // final myController = TextEditingController();
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: kBottomNavigationBackgroundColor,
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: kPageBackgroundColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: TextField(
              controller: myController,
              cursorColor: kHighlightedTextColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  iconColor: kNavigationIconColor,
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   color: kHighlightedTextColor,
                  // ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: kHighlightedTextColor,
                    ),
                    onPressed: () {
                      query = " ";
                      myController.text = "";
                      // print(query);
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
                // print(query);
                buildResults(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Center(
                    child: Text(
                      "Let's see Properties On ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: ToggleButtons(
                    constraints: BoxConstraints(minHeight: 8),
                    fillColor: kHighlightedTextColor,
                    borderWidth: 2,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Rent',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sale',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        searchType =
                            index == 0 ? "PropertiesRent" : "PropertiesSell";
                      });
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    },
                    isSelected: isSelected,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 20,
              child: Stack(children: [
                Opacity(
                  opacity: 0.5,
                  child: Center(
                    child: Container(
                      child: Image(
                        image: AssetImage("images/try10.png"),
                      ),
                    ),
                  ),
                ),
                buildResults(context)
              ]),
            ),
            // BottomPageNavigationBar(
            //   flex_by: 2,
            //   page: searchScreen.id,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: scaffoldBottomAppBar(
        flex_by: 2,
        page: searchScreen.id,
      ),
    );
  }
}

class SearchedProperties extends StatefulWidget {
  final String imageloc;
  final String propertyName;
  final String propertyAddress;
  final String price;
  final String propertyDescription;
  final String to;
  final String ownerName;
  final String ownerMail;
  final String ownerPhno;
  final String propertyType;
  final String bedRoom;
  final String bathRoom;
  final String propertyCategory;
  final String area;
  final String lenght;
  final String width;
  final String constructionArea;
  final String ownerImgUrl;
  final String cent;
  final String face;
  final List<String> propertyImages;
  const SearchedProperties(
      {required this.imageloc,
      required this.ownerMail,
      required this.ownerPhno,
      required this.ownerImgUrl,
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
      required this.lenght,
      required this.width,
      required this.constructionArea,
      required this.cent,
      required this.face,
      required this.area});
  @override
  State<SearchedProperties> createState() => _SearchedPropertiesState();
}

class _SearchedPropertiesState extends State<SearchedProperties> {
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
        height: 120,
        // color: kSecondaryButtonColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  cacheManager: customCacheManager,
                  key: UniqueKey(),
                  imageUrl: widget.imageloc,
                  height: 110,
                  width: 110,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.propertyName,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.propertyAddress,
                    style: TextStyle(
                        color: kBottomNavigationBackgroundColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 32, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.price + " \u{20B9}",
                        style: TextStyle(
                            fontSize: 15,
                            color: kHighlightedTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.to == "Rent" ? " / Month" : "",
                        style: TextStyle(
                            fontSize: 10,
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, PropertyDetailsScreen.id);
                          print("ViewDetails Pressed");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetailsScreen(
                                ownerMail: widget.ownerMail,
                                ownerPhoneNo: widget.ownerPhno,
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
                                face: widget.face,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'View Details',
                          style: TextStyle(color: kPrimaryButtonColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
