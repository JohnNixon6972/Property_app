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

class UnApprovedPropertiesScreen extends StatefulWidget {
  static const id = 'unApprovedPropertiesScreen';
  @override
  State<UnApprovedPropertiesScreen> createState() =>
      _UnApprovedPropertiesScreenState();
}

class _UnApprovedPropertiesScreenState
    extends State<UnApprovedPropertiesScreen> {
  Widget buildunApprovedProperties() {
    return AnimationLimiter(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: unApprovedProperties.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                duration: Duration(seconds: 3),
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  duration: Duration(seconds: 3),
                  child: Padding(
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
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(20)),
                                child: CachedNetworkImage(
                                  cacheManager: customCacheManager,
                                  key: UniqueKey(),
                                  imageUrl:
                                      unApprovedProperties[index].imageloc,
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
                                unApprovedProperties[index].propertyName,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                unApprovedProperties[index].propertyAddress,
                                style: const TextStyle(
                                  color: kSubCategoryColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\u{20B9} ${unApprovedProperties[index].price} ",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: kHighlightedTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  unApprovedProperties[index].to == "Rent"
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
                                              dtcpApproved: unApprovedProperties[index].dtcpApproved,
                                              city: unApprovedProperties[index].city,
                                              taluk: unApprovedProperties[index].taluk,
                                          state:
                                              unApprovedProperties[index].state,
                                          district: unApprovedProperties[index]
                                              .district,
                                          ownerMail: unApprovedProperties[index]
                                              .ownerMail,
                                          ownerPhoneNo:
                                              unApprovedProperties[index]
                                                  .ownerPhoneNo,
                                          type: unApprovedProperties[index]
                                              .propertyType,
                                          category: unApprovedProperties[index]
                                              .propertyCategory,
                                          propertyAddress:
                                              unApprovedProperties[index]
                                                  .propertyAddress,
                                          propertyTitle:
                                              unApprovedProperties[index]
                                                  .propertyName,
                                          to: unApprovedProperties[index].to,
                                          ownerName: unApprovedProperties[index]
                                              .ownerName,
                                          propertyDescription:
                                              unApprovedProperties[index]
                                                  .propertyDescription,
                                          noBathroom:
                                              unApprovedProperties[index]
                                                  .bathRoom,
                                          noBedroom: unApprovedProperties[index]
                                              .bedRoom,
                                          area:
                                              unApprovedProperties[index].area,
                                          propertyImages:
                                              unApprovedProperties[index]
                                                  .propertyImages,
                                          price:
                                              unApprovedProperties[index].price,
                                          lenght: unApprovedProperties[index]
                                              .lenght,
                                          width:
                                              unApprovedProperties[index].width,
                                          constructionArea:
                                              unApprovedProperties[index]
                                                  .constructionArea,
                                          ownerImgUrl:
                                              unApprovedProperties[index]
                                                  .ownerImgUrl,
                                          cent:
                                              unApprovedProperties[index].cent,
                                          face: unApprovedProperties[index]
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
                                                "Approve Property ?",
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
                                                                    unApprovedProperties[
                                                                            index]
                                                                        .to;
                                                            setState(() {
                                                              final firestore =
                                                                  FirebaseFirestore
                                                                      .instance;

                                                              unApprovedPropertiesNames.remove(
                                                                  unApprovedProperties[
                                                                          index]
                                                                      .propertyName);
                                                              firestore
                                                                  .collection(
                                                                      collection)
                                                                  .doc(unApprovedProperties[
                                                                          index]
                                                                      .propertyName)
                                                                  .update({
                                                                "isApproved":
                                                                    "True"
                                                              });
                                                              print(
                                                                  "Property Approved Sucessfully");
                                                              unApprovedProperties
                                                                  .remove(
                                                                      unApprovedProperties[
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
                                    Icons.approval_rounded,
                                    size: 25,
                                    color: kHighlightedTextColor,
                                  ),
                                ),
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
                                                                    unApprovedProperties[
                                                                            index]
                                                                        .to;
                                                            setState(() {
                                                              final firestore =
                                                                  FirebaseFirestore
                                                                      .instance;

                                                              firestore
                                                                  .collection(
                                                                      collection)
                                                                  .doc(unApprovedProperties[
                                                                          index]
                                                                      .propertyName)
                                                                  .delete();

                                                              if (bookmarkedPropertyNames.contains(
                                                                  unApprovedProperties[
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
                                                                    .doc(unApprovedProperties[
                                                                            index]
                                                                        .propertyName)
                                                                    .delete();
                                                                bookmarkedPropertyNames.remove(
                                                                    unApprovedProperties[
                                                                            index]
                                                                        .propertyName);
                                                              }

                                                              print(
                                                                  "asset/propertyImages/${userInfo.mobileNumber}/${unApprovedProperties[index].propertyName}");
                                                              FirebaseStorage
                                                                  .instance
                                                                  .ref(
                                                                      "asset/propertyImages/${userInfo.mobileNumber}/${unApprovedProperties[index].propertyName}")
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
                                                              unApprovedProperties
                                                                  .remove(
                                                                      unApprovedProperties[
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
                    width: 60,
                  ),
                  const Center(
                    child: const Text(
                      'UnApproved Properties',
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
            Expanded(flex: 10, child: buildunApprovedProperties()),
            const BottomPageNavigationBar(
              flex_by: 1,
              page: UnApprovedPropertiesScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}
