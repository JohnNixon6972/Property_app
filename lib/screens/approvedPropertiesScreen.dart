import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';
import '../components/bottomNavigationBar.dart';
import '../constants.dart';
import '../main.dart';
import './homescreen.dart';

class ApprovedPropertiesScreen extends StatefulWidget {
  static const id = 'approvedPropertiesScreen';
  @override
  State<ApprovedPropertiesScreen> createState() =>
      _ApprovedPropertiesScreenState();
}

class _ApprovedPropertiesScreenState extends State<ApprovedPropertiesScreen> {
  Widget buildapprovedProperties() {
    return AnimationLimiter(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: approvedProperties.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                duration: const Duration(seconds: 3),
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  duration: const Duration(seconds: 3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPropertyCardColor,
                        border: Border.all(color: kHighlightedTextColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
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
                                    const BorderRadius.all(Radius.circular(20)),
                                child: CachedNetworkImage(
                                  cacheManager: customCacheManager,
                                  key: UniqueKey(),
                                  imageUrl: approvedProperties[index].imageloc,
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
                                  errorWidget: (context, url, error) =>
                                      Container(
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
                                approvedProperties[index].propertyName,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                approvedProperties[index].propertyAddress,
                                style: const TextStyle(
                                  color: kSubCategoryColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\u{20B9} ${approvedProperties[index].price} ",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: kHighlightedTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  approvedProperties[index].to == "Rent"
                                      ? " / Month"
                                      : "",
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
                                        builder: (context) =>
                                            PropertyDetailsScreen(
                                              dtcpApproved: approvedProperties[index].dtcpApproved,
                                          city: approvedProperties[index].city,
                                          taluk:
                                              approvedProperties[index].taluk,
                                          state:
                                              approvedProperties[index].state,
                                          district: approvedProperties[index]
                                              .district,
                                          ownerMail: approvedProperties[index]
                                              .ownerMail,
                                          ownerPhoneNo:
                                              approvedProperties[index]
                                                  .ownerPhoneNo,
                                          type: approvedProperties[index]
                                              .propertyType,
                                          category: approvedProperties[index]
                                              .propertyCategory,
                                          propertyAddress:
                                              approvedProperties[index]
                                                  .propertyAddress,
                                          propertyTitle:
                                              approvedProperties[index]
                                                  .propertyName,
                                          to: approvedProperties[index].to,
                                          ownerName: approvedProperties[index]
                                              .ownerName,
                                          propertyDescription:
                                              approvedProperties[index]
                                                  .propertyDescription,
                                          noBathroom: approvedProperties[index]
                                              .bathRoom,
                                          noBedroom:
                                              approvedProperties[index].bedRoom,
                                          area: approvedProperties[index].area,
                                          propertyImages:
                                              approvedProperties[index]
                                                  .propertyImages,
                                          price:
                                              approvedProperties[index].price,
                                          lenght:
                                              approvedProperties[index].lenght,
                                          width:
                                              approvedProperties[index].width,
                                          constructionArea:
                                              approvedProperties[index]
                                                  .constructionArea,
                                          ownerImgUrl: approvedProperties[index]
                                              .ownerImgUrl,
                                          cent: approvedProperties[index].cent,
                                          face: approvedProperties[index]
                                              .direction,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'View Details',
                                    style:
                                        TextStyle(color: kPrimaryButtonColor),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // Timer _timer;
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext builderContext) {
                                            // _timer = Timer(Duration(seconds: 3), () {
                                            //   Navigator.of(context).pop();
                                            // });
                                            return SimpleDialog(
                                              backgroundColor:
                                                  kPageBackgroundColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      const Spacer(),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            String collection =
                                                                "Properties" +
                                                                    approvedProperties[
                                                                            index]
                                                                        .to;
                                                            setState(() {
                                                              final firestore =
                                                                  FirebaseFirestore
                                                                      .instance;

                                                              firestore
                                                                  .collection(
                                                                      collection)
                                                                  .doc(approvedProperties[
                                                                          index]
                                                                      .propertyName)
                                                                  .delete();

                                                              if (bookmarkedPropertyNames.contains(
                                                                  approvedProperties[
                                                                          index]
                                                                      .propertyName)) {
                                                                print("Hi");

                                                                final _firestore =
                                                                    FirebaseFirestore
                                                                        .instance;

                                                                _firestore
                                                                    .collection(
                                                                        "Users")
                                                                    .doc(userInfo
                                                                        .mobileNumber)
                                                                    .collection(
                                                                        "BookMarkedProperties")
                                                                    .doc(approvedProperties[
                                                                            index]
                                                                        .propertyName)
                                                                    .delete();
                                                                bookmarkedPropertyNames.remove(
                                                                    approvedProperties[
                                                                            index]
                                                                        .propertyName);
                                                              }

                                                              FirebaseStorage
                                                                  .instance
                                                                  .ref(
                                                                      "asset/propertyImages/${userInfo.mobileNumber}/${approvedProperties[index].propertyName}")
                                                                  .listAll()
                                                                  .then(
                                                                      (value) {
                                                                value.items
                                                                    .forEach(
                                                                        (element) {
                                                                  FirebaseStorage
                                                                      .instance
                                                                      .ref(element
                                                                          .fullPath)
                                                                      .delete();
                                                                });
                                                              });
                                                              approvedPropertiesNames.remove(
                                                                  approvedProperties[
                                                                          index]
                                                                      .propertyName);
                                                              approvedProperties
                                                                  .remove(
                                                                      approvedProperties[
                                                                          index]);

                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          });
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kBottomNavigationBackgroundColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kPrimaryButtonColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'No',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                  ),
                ),
              ),
            );
          }),
    );
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
                    width: 55,
                  ),
                  const Center(
                    child: Text(
                      'All Approved Properties',
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
            Expanded(flex: 10, child: buildapprovedProperties()),
            const BottomPageNavigationBar(
              flex_by: 1,
              page: ApprovedPropertiesScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}

class approvedProperty extends StatefulWidget {
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
  const approvedProperty(
      {required this.imageloc,
      required this.lenght,
      required this.face,
      required this.width,
      required this.constructionArea,
      required this.ownerMail,
      required this.cent,
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
      required this.ownerImgUrl,
      required this.area});
  @override
  State<approvedProperty> createState() => _approvedPropertyState();
}

class _approvedPropertyState extends State<approvedProperty> {
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
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
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
                      // Navigator.pushNamed(context, profileScreen.id);
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
