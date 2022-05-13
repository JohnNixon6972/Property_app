import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/homescreen.dart';
// import 'package:sticky_headers/sticky_headers.dart';
import '../constants.dart';
import 'dart:math';
import 'propertyDetailsScreen.dart';
import '../components/bottomNavigationBar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BookmarkedPropertiesScreen extends StatefulWidget {
  static const id = 'BookmarkedPropertiesScreen';
  @override
  State<BookmarkedPropertiesScreen> createState() =>
      _BookmarkedPropertiesScreenState();
}

List<BookmarkedProperties> bookMarkedProperties = [];
void getBookMarkedPropertiesCards() {
  bookMarkedProperties = [];
  // print(bookmarkedPropertyNames);
  // print(PropertiesOnRentAll);
  // print(PropertiesOnSaleAll);
  for (PropertyCard property in PropertiesOnRentAll) {
    if (bookmarkedPropertyNames.contains(property.propertyName)) {
      bookMarkedProperties.add(BookmarkedProperties(
        imageloc: property.imageloc,
        price: property.price,
        propertyAddress: property.propertyAddress,
        propertyName: property.propertyName,
        propertyImages: property.propertyImages,
        propertyCategory: property.propertyCategory,
        propertyDescription: property.propertyDescription,
        propertyType: property.propertyType,
        bedRoom: property.bedRoom,
        bathRoom: property.bathRoom,
        ownerName: property.ownerName,
        to: property.to,
        area: property.area,
      ));
    }
  }
  for (PropertyCard property in PropertiesOnSaleAll) {
    if (bookmarkedPropertyNames.contains(property.propertyName)) {
      bookMarkedProperties.add(BookmarkedProperties(
        imageloc: property.imageloc,
        price: property.price,
        propertyAddress: property.propertyAddress,
        propertyName: property.propertyName,
        propertyImages: property.propertyImages,
        propertyCategory: property.propertyCategory,
        propertyDescription: property.propertyDescription,
        propertyType: property.propertyType,
        bedRoom: property.bedRoom,
        bathRoom: property.bathRoom,
        ownerName: property.ownerName,
        to: property.to,
        area: property.area,
      ));
    }
  }
  print(bookMarkedProperties);
}

class _BookmarkedPropertiesScreenState
    extends State<BookmarkedPropertiesScreen> {
  @override
  void initState() {
    super.initState();
    getBookMarkedPropertiesCards();
  }

  Widget buildBookMarks() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: bookmarkedPropertyNames.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                          cacheManager: customCacheManager,
                          key: UniqueKey(),
                          imageUrl: bookMarkedProperties[index].imageloc,
                          height: 200,
                          width: double.infinity,

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
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        bookMarkedProperties[index].propertyName,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        bookMarkedProperties[index].propertyAddress,
                        style: TextStyle(
                          color: kSubCategoryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${bookMarkedProperties[index].price}",
                          style: TextStyle(
                              fontSize: 18,
                              color: kHighlightedTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bookMarkedProperties[index].to == "Rent"
                              ? " / Month"
                              : "",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyDetailsScreen(
                                    propertyAddress: bookMarkedProperties[index]
                                        .propertyAddress,
                                    propertyTitle: bookMarkedProperties[index]
                                        .propertyName,
                                    to: bookMarkedProperties[index].to,
                                    ownerName:
                                        bookMarkedProperties[index].ownerName,
                                    propertyDescription:
                                        bookMarkedProperties[index]
                                            .propertyDescription,
                                    noBathroom:
                                        bookMarkedProperties[index].bathRoom,
                                    noBedroom:
                                        bookMarkedProperties[index].bedRoom,
                                    area: bookMarkedProperties[index].area,
                                    propertyImages: bookMarkedProperties[index]
                                        .propertyImages,
                                    price: bookMarkedProperties[index].price),
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
                              final firestore = FirebaseFirestore.instance;
                              firestore
                                  .collection("Users")
                                  .doc(userInfo.email)
                                  .collection("BookMarkedProperties")
                                  .doc(bookMarkedProperties[index].propertyName)
                                  .delete();
                              bookmarkedPropertyNames.remove(
                                  bookMarkedProperties[index].propertyName);
                              bookMarkedProperties.removeAt(index);
                              print(bookMarkedProperties);
                        
                              // getBookMarkedProperties();
                            });
                          },
                          icon: Icon(Icons.bookmark,
                              color: kHighlightedTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          ;
        });
  }

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
              color: kHighlightedTextColor,
            ),
            Expanded(
                flex: 10,
                // child: SingleChildScrollView(
                //   physics: BouncingScrollPhysics(),
                //   child: Padding(
                //     padding: EdgeInsets.all(12),
                //     child: Column(
                //         mainAxisSize: MainAxisSize.max,
                //         children: bookMarkedProperties),
                //   ),
                // ),
                child: buildBookMarks()),
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
  const BookmarkedProperties(
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
  State<BookmarkedProperties> createState() => _BookmarkedPropertiesState();
}

class _BookmarkedPropertiesState extends State<BookmarkedProperties> {
  late bool bookedmark = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
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
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    cacheManager: customCacheManager,
                    key: UniqueKey(),
                    imageUrl: widget.imageloc,
                    height: 200,
                    width: double.infinity,

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
                    "\$${widget.price}",
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
                        final firestore = FirebaseFirestore.instance;
                        firestore
                            .collection("Users")
                            .doc(userInfo.email)
                            .collection("BookMarkedProperties")
                            .doc(widget.propertyName)
                            .delete();
                        bookMarkedProperties.remove(widget);
                        bookmarkedPropertyNames.remove(widget.propertyName);
                        print(bookMarkedProperties);
                        // getBookMarkedProperties();
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
      ),
    );
  }
}
