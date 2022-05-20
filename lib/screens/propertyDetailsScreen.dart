// import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import '../constants.dart';
import 'package:open_mail_app/open_mail_app.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDetailsScreen extends StatelessWidget {
  static const id = 'propertyDetailsScreen';
  final String ownerMail;
  final String ownerPhoneNo;
  final String propertyTitle;
  final String propertyAddress;
  final String propertyDescription;
  final String noBathroom;
  final String noBedroom;
  final String area;
  final String ownerName;
  final String to;
  final String price;
  final String category;
  final String type;
  final List<String> propertyImages;
  const PropertyDetailsScreen(
      {Key? key,
      required this.ownerMail,
      required this.ownerPhoneNo,
      required this.propertyTitle,
      required this.propertyAddress,
      required this.propertyDescription,
      required this.noBathroom,
      required this.noBedroom,
      required this.area,
      required this.ownerName,
      required this.to,
      required this.price,
      required this.category,
      required this.type,
      required this.propertyImages})
      : super(key: key);

  Widget buildListView(List<String> propertyImages, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
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
              borderRadius: const BorderRadius.all(
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
                  child: const Icon(
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
                      child: const Icon(
                        Icons.expand_less_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 115,
                  ),
                  const Center(
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
                padding: const EdgeInsets.only(top: 18, bottom: 18),
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
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kHighlightedTextColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        propertyAddress,
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
                        "\u{20B9} $price ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: kHighlightedTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        to == "Rent" ? " / Month" : "",
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
                  propertyDescription,
                  style: const TextStyle(
                      fontSize: 15,
                      color: kHighlightedTextColor,
                      fontWeight: FontWeight.w400),
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
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
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 140,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.currency_rupee_sharp,
                              color: kHighlightedTextColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Property On',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              to,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 140,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.home_work_outlined,
                              color: kHighlightedTextColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Category',
                              style: TextStyle(
                                  color: kHighlightedTextColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              category,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 140,
                    decoration: const BoxDecoration(
                        color: kSecondaryButtonColor,
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.landscape,
                            color: kHighlightedTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Type',
                            style: TextStyle(
                                color: kHighlightedTextColor, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            type,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 140,
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
                              noBathroom,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 140,
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
                              noBedroom,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 140,
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
                            '$area SqFt.',
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
                        ownerName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kHighlightedTextColor),
                      ),
                      Text(
                        ownerName != "admin" ? 'Owner' : "Admin",
                        style: const TextStyle(
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
                      GestureDetector(
                        onTap: () async {
                          EmailContent email = EmailContent(
                            to: [
                              ownerMail,
                            ],
                          );

                          OpenMailAppResult result =
                              await OpenMailApp.composeNewEmailInMailApp(
                                  nativePickerTitle:
                                      'Select email app to compose',
                                  emailContent: email);
                          if (!result.didOpen && !result.canOpen) {
                            // showNoMailAppsDialog(context);
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                              context: context,
                              builder: (_) => MailAppPickerDialog(
                                mailApps: result.options,
                                emailContent: email,
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.mail,
                            size: 30,
                            color: kHighlightedTextColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = 'tel:' + ownerPhoneNo.toString();
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.call,
                            size: 30,
                            color: kHighlightedTextColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
