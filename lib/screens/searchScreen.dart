import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

import '../components/bottomNavigationBar.dart';
import './homescreen.dart';

class searchScreen extends StatefulWidget {
  static const String id = 'searchScreen';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  String query = "";
  CollectionReference _saleCollection =
      FirebaseFirestore.instance.collection("PropertiesSell");
  Icon customIcon = const Icon(
    Icons.search,
    color: kPrimaryButtonColor,
  );
  Widget customSearchBar = const Text(
    'Search',
    style: TextStyle(color: kPrimaryButtonColor),
  );

  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _saleCollection.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: kHighlightedTextColor,
              ),
            );
          } else {
            print(snapshot.data);
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
                      return Property;
                    } catch (e) {
                      print(e);
                    }
                  }else{
                    // return Center(child: circular,)
                  }
                })
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
            top: Radius.circular(30),
          ),
        ),
        backgroundColor: kBottomNavigationBackgroundColor,
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  // Perform set of instructions.
                  customIcon = const Icon(
                    Icons.cancel,
                    color: kPrimaryButtonColor,
                  );
                  customSearchBar = ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: kPrimaryButtonColor,
                      size: 28,
                    ),
                    title: TextField(
                      onChanged: (value) {
                        query = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type your text here',
                        hintStyle: TextStyle(
                          color: kPrimaryButtonColor,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: kPrimaryButtonColor,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text(
                    'Search',
                    style: TextStyle(
                      color: kPrimaryButtonColor,
                    ),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Opacity(
                opacity: 0.5,
                child: Stack(children: [
                  Center(
                    child: Container(
                      child: Image(
                        image: AssetImage("images/try10.png"),
                      ),
                    ),
                  ),
                  buildResults(context)
                ]),
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 1,
              page: searchScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}
