// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/raiseIssue.dart';
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
      backgroundColor: kSubCategoryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                // color: kHighlightedTextColor,
                height: 200,
                padding: const EdgeInsets.only(
                    top: 50, left: 25, right: 25, bottom: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "images/requestProperty.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: kPageBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20),
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
                            const Text(
                              "Buyer Name",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kHighlightedTextColor),
                            ),
                            const Text(
                              "ownerName" != "admin" ? 'Owner' : "Admin",
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
                              child: const Padding(
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
                              child: const Padding(
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
                    const Text(
                      "Description if any",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        "Utility and Specification",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kHighlightedTextColor),
                      ),
                    ),
                    const specifications(
                      title: "Property to",
                      subtitle: "Buy / Rent",
                    ),
                    const specifications(
                      title: "Property type",
                      subtitle: "Residential",
                    ),
                    const specifications(
                      title: "Category",
                      subtitle: "Plot / Land etc",
                    ),
                    const specifications(
                      title: "District",
                      subtitle: "District name",
                    ),
                    const specifications(
                      title: "Taluk",
                      subtitle: "Taluk Name",
                    ),
                    const specifications(
                      title: "City",
                      subtitle: "City Name",
                    ),
                    const specifications(
                      title: "Length",
                      subtitle: "Lgt",
                    ),
                    const specifications(
                      title: "Breath",
                      subtitle: "Bth",
                    ),
                    const specifications(
                      title: "Price",
                      subtitle: "Rs",
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, raiseAnIssue.id);
                            },
                            child: const Text(
                              'Browse More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: kBottomNavigationBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              var url = 'tel:6361125470'.toString();
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              'Contact Buyer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: kBottomNavigationBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class specifications extends StatelessWidget {
  final String title;
  final String subtitle;
  const specifications({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          width: (MediaQuery.of(context).size.width / 2) - 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: kHighlightedTextColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          width: (MediaQuery.of(context).size.width / 2) - 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: kHighlightedTextColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
