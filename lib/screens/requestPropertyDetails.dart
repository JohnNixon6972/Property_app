// ignore_for_file: file_names

import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

void data(category, city, taluk, district, state, price, to) {}

class requestPropertyDetails extends StatefulWidget {
  static const id = 'requestedPropertyDetailsScreen';

  @override
  State<requestPropertyDetails> createState() => _requestPropertyDetailsState();
}

class _requestPropertyDetailsState extends State<requestPropertyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
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
                      color: kHighlightedTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.8,
                ),
                const Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kHighlightedTextColor),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              indent: 90,
              endIndent: 90,
              color: kHighlightedTextColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: CircleAvatar(
                    backgroundColor: null,
                    radius: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        // cacheManager: customCacheManager,
                        key: UniqueKey(),
                        imageUrl: userInfo.profileImgUrl,
                        height: 50,
                        width: 50,
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ownerName",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                    Text(
                      "ownerName" != "admin" ? 'Owner' : "Admin",
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
                            "ownerMail",
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
                        var url = 'tel:' + "ownerPhoneNo".toString();
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
            Container(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              height: 300,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                child: Image.asset(
                  'images/requestProperty.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            // city +
                            "A Catogory is required in",
                            //  + taluk + "\n" + district + ", " + state,
                            style: TextStyle(
                                fontSize: 23,
                                color: kBottomNavigationBackgroundColor),
                          ),
                          const Text(
                            // city +
                            "city , taluk\ndistrict, state for",
                            //  + taluk + "\n" + district + ", " + state,
                            style: TextStyle(
                                fontSize: 22,
                                color: kBottomNavigationBackgroundColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\u{20B9} "
                                //  +  price
                                .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => "${m[1]},")
                                .toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: kHighlightedTextColor,
                            ),
                          ),
                          const Text(
                            "to .",
                            // == "Rent" ? " / Month" : "",
                            style: TextStyle(
                              fontSize: 22,
                              color: kBottomNavigationBackgroundColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
