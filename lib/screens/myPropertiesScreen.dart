import 'dart:async';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/editPropertyScreen1.dart';
// import 'package:property_app/screens/bookmarkedpropertiesscreen.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/profileScreen.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
import '../components/bottomNavigationBar.dart';
import '../storage_service.dart';

class myPropertiesScreen extends StatefulWidget {
  static const id = 'myProperties';

  @override
  State<myPropertiesScreen> createState() => _myPropertiesScreenState();
}

List<myProperty> myProperties = [];
void getMyPropertiesCards() {
  myProperties = [];
  // print(bookmarkedPropertyNames);
  // print(PropertiesOnRentAll);
  // print(PropertiesOnSaleAll);
  for (PropertyCard property in PropertiesOnRentAll) {
    if (myPropertiesAdv.contains(property.propertyName)) {
      myProperties.add(myProperty(
        ownerMail: property.ownerMail,
        ownerPhno: property.ownerPhoneNo,
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
    if (myPropertiesAdv.contains(property.propertyName)) {
      myProperties.add(myProperty(
        ownerMail: property.ownerMail,
        ownerPhno: property.ownerPhoneNo,
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
  print(myProperties);
  print(bookmarkedPropertyNames);
}

class _myPropertiesScreenState extends State<myPropertiesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyPropertiesCards();
    // print(myPropertiesAdv);
  }

  Widget buildMyProperties() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: myPropertiesAdv.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: kPropertyCardColor,
                border: Border.all(color: kHighlightedTextColor),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(20),
                ),
              ),
              // height: 352,
              // width: 300,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(20)),
                        child: CachedNetworkImage(
                          cacheManager: customCacheManager,
                          key: UniqueKey(),
                          imageUrl: myProperties[index].imageloc,
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
                        myProperties[index].propertyName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        myProperties[index].propertyAddress,
                        style: const TextStyle(
                          color: kSubCategoryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\u{20B9} ${myProperties[index].price} ",
                          style: const TextStyle(
                              fontSize: 18,
                              color: kHighlightedTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          myProperties[index].to == "Rent" ? " / Month" : "",
                          style: const TextStyle(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyDetailsScreen(
                                    ownerMail: myProperties[index].ownerMail,
                                    ownerPhoneNo: myProperties[index].ownerPhno,
                                    type: myProperties[index].propertyType,
                                    category:
                                        myProperties[index].propertyCategory,
                                    propertyAddress:
                                        myProperties[index].propertyAddress,
                                    propertyTitle:
                                        myProperties[index].propertyName,
                                    to: myProperties[index].to,
                                    ownerName: myProperties[index].ownerName,
                                    propertyDescription:
                                        myProperties[index].propertyDescription,
                                    noBathroom: myProperties[index].bathRoom,
                                    noBedroom: myProperties[index].bedRoom,
                                    area: myProperties[index].area,
                                    propertyImages:
                                        myProperties[index].propertyImages,
                                    price: myProperties[index].price),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPropertyScreen1(
                                  propertyToEdit: myProperties[index],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: kHighlightedTextColor,
                          ),
                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: const Text(
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
                                              const Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    String collection =
                                                        "Properties" +
                                                            myProperties[index]
                                                                .to;
                                                    setState(() {
                                                      final firestore =
                                                          FirebaseFirestore
                                                              .instance;

                                                      firestore
                                                          .collection(
                                                              collection)
                                                          .doc(myProperties[
                                                                  index]
                                                              .propertyName)
                                                          .delete();

                                                      if (bookmarkedPropertyNames
                                                          .contains(myProperties[
                                                                  index]
                                                              .propertyName)) {
                                                        print("Hi");

                                                        final _firestore =
                                                            FirebaseFirestore
                                                                .instance;

                                                        _firestore
                                                            .collection("Users")
                                                            .doc(userInfo.email)
                                                            .collection(
                                                                "BookMarkedProperties")
                                                            .doc(myProperties[
                                                                    index]
                                                                .propertyName)
                                                            .delete();
                                                        bookmarkedPropertyNames
                                                            .remove(myProperties[
                                                                    index]
                                                                .propertyName);
                                                      }

                                                      print(
                                                          "asset/propertyImages/${userInfo.email}/${myProperties[index].propertyName}");
                                                      FirebaseStorage.instance
                                                          .ref(
                                                              "asset/propertyImages/${userInfo.email}/${myProperties[index].propertyName}")
                                                          .listAll()
                                                          .then((value) {
                                                        value.items
                                                            .forEach((element) {
                                                          FirebaseStorage
                                                              .instance
                                                              .ref(element
                                                                  .fullPath)
                                                              .delete();
                                                        });
                                                      });
                                                      myPropertiesAdv.remove(
                                                          myProperties[index]
                                                              .propertyName);
                                                      myProperties.remove(
                                                          myProperties[index]);
                                                      Navigator.pop(context);
                                                    });
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      kBottomNavigationBackgroundColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPrimaryButtonColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: kHighlightedTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
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
                    width: 100,
                  ),
                  const Center(
                    child: const Text(
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
            const Divider(
              thickness: 1,
              indent: 60,
              endIndent: 60,
              color: kHighlightedTextColor,
            ),
            Expanded(flex: 10, child: buildMyProperties()),
            const BottomPageNavigationBar(
              flex_by: 1,
              page: myPropertiesScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}

class myProperty extends StatefulWidget {
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
  final List<String> propertyImages;
  const myProperty(
      {required this.imageloc,
      required this.ownerMail,
      required this.ownerPhno,
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
  State<myProperty> createState() => _myPropertyState();
}

class _myPropertyState extends State<myProperty> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: kPropertyCardColor,
          border: Border.all(color: kHighlightedTextColor),
          borderRadius: const BorderRadius.all(
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
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20)),
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
                    "\$${widget.price}",
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
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, profileScreen.id);
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
                                title: const Text(
                                  "Delete Property ?",
                                  style: const TextStyle(
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
                                        const Spacer(),
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
                                        const SizedBox(
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
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      });
                    },
                    icon: const Icon(Icons.delete),
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