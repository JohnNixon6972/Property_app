// import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../constants.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDetailsScreen extends StatelessWidget {
  static const id = 'propertyDetailsScreen';
  final String propertyTitle;
  final String propertyAddress;
  final String propertyDescription;
  final String noBathroom;
  final String noBedroom;
  final String area;
  final String ownerName;
  final String to;
  final String price;
  final List<String> propertyImages;
  PropertyDetailsScreen(
      {required this.propertyTitle,
      required this.propertyAddress,
      required this.propertyDescription,
      required this.noBathroom,
      required this.noBedroom,
      required this.area,
      required this.ownerName,
      required this.to,
      required this.price,
      required this.propertyImages});

  // Completer<GoogleMapController> _controller = Completer();
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  Widget buildListView(List<String> propertyImages, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: propertyImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          // return Image.file(
          //   File(imageFileList![index].path),
          //   fit: BoxFit.cover,
          // );
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              child: CachedNetworkImage(
                imageUrl: propertyImages[index],
                key: UniqueKey(),
                height: 400,
                width: width - 30,
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: 270 * pi / 180,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.expand_less_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Center(
                    child: Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kHighlightedTextColor),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 18, bottom: 18),
                height: 250,
                child: buildListView(propertyImages, context),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        propertyTitle,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kHighlightedTextColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        propertyAddress,
                        style: TextStyle(
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$$price ",
                        style: TextStyle(
                            fontSize: 18,
                            color: kHighlightedTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        to == "Rent" ? " / Month" : "",
                        style: TextStyle(
                            fontSize: 12,
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 15),
                child: Text(
                  propertyDescription,
                  style: TextStyle(
                      fontSize: 15,
                      color: kHighlightedTextColor,
                      fontWeight: FontWeight.w400),
                  // textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: kSecondaryButtonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        color: kHighlightedTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: kSubCategoryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.bathtub_outlined,
                              color: kHighlightedTextColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bathroom',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              noBathroom,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.bed_rounded,
                              color: kHighlightedTextColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bedroom',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              noBedroom,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.crop_square_rounded,
                            color: kHighlightedTextColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Area',
                            style: TextStyle(
                                color: kHighlightedTextColor, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$area FT.',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/profile_img2.jpg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ownerName,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kHighlightedTextColor),
                      ),
                      Text(
                        ownerName != "admin" ? 'Owner' : "Admin",
                        style: TextStyle(
                          color: Color.fromARGB(255, 141, 141, 141),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.mail,
                          size: 30,
                          color: kHighlightedTextColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.call,
                          size: 30,
                          color: kHighlightedTextColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 18),
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      // height: 400,
                      width: double.infinity,
                      height: 250,
                      image: AssetImage('images/propertyDetailed1.jpg'),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 200,
              //   width: 400,
              //   child: GoogleMap(
              //       initialCameraPosition: CameraPosition(
              //           target: LatLng(-33.870840, 151.206286), zoom: 12)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
