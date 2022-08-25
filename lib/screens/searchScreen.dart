import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:property_app/components/scaffoldBottomAppBar.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';

import '../components/loactionData.dart';
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
  late String taluk = "";
  List<String>? districts = Districts['Tamil Nadu'];
  late String district = districts![0];
  int selectedDistrict = 0;
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
            return const Center(
              child: CircularProgressIndicator(
                color: kHighlightedTextColor,
              ),
            );
          } else if (query == "" && district == "") {
            return Container();
          } else {
            if (query != "" &&
                snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['PropertyAddress']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .isEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No Such Property Found!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kSubCategoryColor),
                  ),
                ],
              );
            } else if (query != "") {
              return AnimationLimiter(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        duration: const Duration(seconds: 2),
                        child: FadeInAnimation(
                            duration: const Duration(seconds: 2),
                            child: widget)),
                    children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element['City']
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
                        var propertyDescription =
                            property["PropertyDescription"];
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
                        var state = property["State"];
                        var district = property["District"];
                        var city = property["City"];
                        var dtcpApproved = property["DTCPApproved"];
                        dtcpApproved = dtcpApproved == "false" ? false : true;
                        return SearchedProperties(
                          dtcpApproved: dtcpApproved,
                          taluk: taluk,
                          city: city,
                          state: state,
                          district: district,
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
                  ),
                ),
              );
            } else {
              return AnimationLimiter(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                        duration: const Duration(seconds: 2),
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                            duration: const Duration(seconds: 2),
                            child: widget)),
                    children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element["District"].toString().toLowerCase() ==
                                  district.toLowerCase() &&
                              element["Taluk"].toString().toLowerCase() ==
                                  taluk.toLowerCase())
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
                        var propertyDescription =
                            property["PropertyDescription"];
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
                        var state = property["State"];
                        var district = property["District"];
                        var city = property["City"];
                        var dtcpApproved = property["DTCPApproved"];
                        dtcpApproved = dtcpApproved == "false" ? false : true;
                        return SearchedProperties(
                          dtcpApproved: dtcpApproved,
                          taluk: taluk,
                          city: city,
                          state: state,
                          district: district,
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
                  ),
                ),
              );
            }
          }
        });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<String>? talukas = Taluka[district];
    // final myController = TextEditingController();
    int selectedTaluk = 0;
    void setTaluka(List<String>? talukstobeset) {
      setState(() {
        talukas = talukstobeset!;
        selectedTaluk = 0;
        taluk = talukas![0];
      });
    }

    double _kItemExtent = 32.0;
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: const Radius.circular(25),
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
                  contentPadding: const EdgeInsets.all(8),
                  iconColor: kNavigationIconColor,
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   color: kHighlightedTextColor,
                  // ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: kHighlightedTextColor,
                    ),
                    onPressed: () {
                      query = " ";
                      myController.text = "";
                      // print(query);
                    },
                  ),
                  hintText: 'Search...with City Name',
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text("Properties From : Tamil Nadu"),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 6),
                      child: GestureDetector(
                        onTap: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                selectedDistrict = selectedItem;
                                district = districts![selectedDistrict];
                                print(district);
                                setTaluka(Taluka[district]);
                                buildResults(context);
                              });
                            },
                            children: List<Widget>.generate(districts!.length,
                                (int index) {
                              print(districts);
                              return Center(
                                child: Text(
                                  districts![index],
                                ),
                              );
                            }),
                          ),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: kHighlightedTextColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Text(
                              "District : " + district,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 6),
                    child: GestureDetector(
                      onTap: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: _kItemExtent,
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              selectedTaluk = selectedItem;
                              taluk = talukas![selectedTaluk];
                              print(taluk);
                            });
                          },
                          children: List<Widget>.generate(talukas!.length,
                              (int index) {
                            print(talukas);
                            return Center(
                              child: Text(
                                talukas![index],
                              ),
                            );
                          }),
                        ),
                      ),
                      child: Container(
                        height: 60,
                        width: 155,
                        decoration: BoxDecoration(
                          border: Border.all(color: kHighlightedTextColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            "Taluka : " + taluk,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Center(
                    child: const Text(
                      "Let's see Properties On ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: ToggleButtons(
                    constraints: const BoxConstraints(minHeight: 8),
                    fillColor: kBottomNavigationBackgroundColor,
                    borderWidth: 2,
                    borderColor: kNavigationIconColor,
                    selectedColor: kHighlightedTextColor,
                    disabledColor: kHighlightedTextColor,
                    borderRadius: BorderRadius.circular(35),
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Rent',
                          style: TextStyle(
                              fontSize: 14, color: kHighlightedTextColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sale',
                          style: TextStyle(
                              fontSize: 14, color: kHighlightedTextColor),
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
                const Opacity(
                  opacity: 0.5,
                  child: Center(
                    child: Image(
                      image: AssetImage("images/try10.png"),
                    ),
                  ),
                ),
                buildResults(context)
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const scaffoldBottomAppBar(
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
  final String state;
  final String district;
  final String city;
  final String taluk;
  final bool dtcpApproved;
  final List<String> propertyImages;
  const SearchedProperties(
      {required this.imageloc,
      required this.dtcpApproved,
      required this.city,
      required this.taluk,
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
      required this.state,
      required this.district,
      required this.area});
  @override
  State<SearchedProperties> createState() => _SearchedPropertiesState();
}

class _SearchedPropertiesState extends State<SearchedProperties> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          color: kPropertyCardColor,
          borderRadius: const BorderRadius.all(
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
                    child: const Icon(
                      Icons.error,
                      color: kHighlightedTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.propertyName.length > 15
                          ? widget.propertyName.substring(0, 14)
                          : widget.propertyName,
                      style: const TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    widget.propertyAddress,
                    style: const TextStyle(
                        color: kBottomNavigationBackgroundColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.district + ",\n" + widget.state,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 32, bottom: 10),
              child: Column(
                children: [
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
                            fontSize: 15,
                            color: kHighlightedTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.to == "Rent" ? " / Month" : "",
                        style: const TextStyle(
                            fontSize: 10,
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const Spacer(),
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
                                dtcpApproved: widget.dtcpApproved,
                                city: widget.city,
                                taluk: widget.taluk,
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
                                state: widget.state,
                                district: widget.district,
                              ),
                            ),
                          );
                        },
                        child: const Text(
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
