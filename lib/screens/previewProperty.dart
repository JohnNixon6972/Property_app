import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import '../constants.dart';
import 'dart:io';
import 'package:property_app/currentUserInformation.dart';
import 'package:property_app/main.dart';

class PreviewProperty extends StatefulWidget {
  static const String id = "previewProperty";
  List<XFile>? imageFileList;
  String PropertyTitle;
  String PropertyAddress;
  String PropertyDescription;
  String Price;
  String to;
  String BathRoom;
  String BedRoom;
  String Area;
  PreviewProperty(
      {Key? key,
      required this.imageFileList,
      required this.PropertyTitle,
      required this.PropertyAddress,
      required this.PropertyDescription,
      required this.Area,
      required this.BathRoom,
      required this.BedRoom,
      required this.Price,
      required this.to})
      : super(key: key);
  @override
  State<PreviewProperty> createState() => _PreviewPropertyState();
}

class _PreviewPropertyState extends State<PreviewProperty> {
  Widget buildListView() {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.imageFileList!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          // return Image.file(
          //   File(imageFileList![index].path),
          //   fit: BoxFit.cover,
          // );
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              child: Image.file(
                File(widget.imageFileList![index].path),
                fit: BoxFit.cover,
                height: 400,
                width: width - 35,
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
                      child: const Icon(
                        Icons.expand_less_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  const Center(
                    child: Text(
                      "Added Property Preview",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kHighlightedTextColor),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                height: 250,
                child: buildListView(),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.PropertyTitle,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kHighlightedTextColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.PropertyAddress,
                        style: const TextStyle(
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\u{20B9} ${widget.Price}",
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
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 15),
                child: Text(
                  widget.PropertyDescription,
                  style: const TextStyle(
                      fontSize: 15,
                      color: kHighlightedTextColor,
                      fontWeight: FontWeight.w400),
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: 340,
                decoration: const BoxDecoration(
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
                      decoration: const BoxDecoration(
                        color: kHighlightedTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Center(
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
                      decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Center(
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 130,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.bathtub_outlined,
                              color: kHighlightedTextColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Bathroom',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.BathRoom,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 130,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.bed_rounded,
                              color: kHighlightedTextColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Bedroom',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.BedRoom,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 130,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.crop_square_rounded,
                            color: kHighlightedTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Area',
                            style: TextStyle(
                                color: kHighlightedTextColor, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${widget.Area} FT.',
                            style: const TextStyle(
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
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/profile_img2.jpg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfo.name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kHighlightedTextColor),
                      ),
                      const Text(
                        'Owner',
                        style: TextStyle(
                          color: Color.fromARGB(255, 141, 141, 141),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.mail,
                          size: 30,
                          color: kHighlightedTextColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
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
                  padding: const EdgeInsets.only(top: 8, bottom: 18),
                  height: 250,
                  width: double.infinity,
                  child: const ClipRRect(
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
