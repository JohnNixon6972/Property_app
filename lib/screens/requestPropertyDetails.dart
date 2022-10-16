// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/raiseIssue.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

void data(category, city, taluk, district, state, price, to) {}

class requestPropertyDetails extends StatelessWidget {
  final IconData icon;
  final String ownerName,
      city,
      taluk,
      to,
      category,
      type,
      price,
      ownerPhno,
      ownerimg,
      state,
      district,
      description,
      length,
      width,
      ownerEmail;
  requestPropertyDetails(
      {required this.icon,
      required this.length,
      required this.width,
      required this.ownerName,
      required this.city,
      required this.taluk,
      required this.to,
      required this.category,
      required this.type,
      required this.price,
      required this.ownerPhno,
      required this.ownerimg,
      required this.state,
      required this.district,
      required this.description,
      required this.ownerEmail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextFieldFillColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                // color: kHighlightedTextColor,
                height: 200,
                padding: const EdgeInsets.only(
                    top: 50, left: 25, right: 25, bottom: 25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "images/$category.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: kTextFieldFillColor,
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
                          Text(
                            ownerName,
                            style: const TextStyle(
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
                                  ownerEmail,
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
                            child: const Icon(
                              Icons.mail,
                              size: 30,
                              color: kHighlightedTextColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var url = 'tel:' + ownerPhno.toString();
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Icon(
                              Icons.call,
                              size: 30,
                              color: kHighlightedTextColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Text(
                      description,
                      style: const TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Center(
                      child: Text(
                        "Utility and Specification",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: kHighlightedTextColor),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kPropertyCardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            specifications(
                              title: "Property to",
                              subtitle: to,
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                                title: "Property type", subtitle: type),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "Category",
                              subtitle: category,
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "District",
                              subtitle: district,
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "Taluk",
                              subtitle: taluk,
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "City",
                              subtitle: city,
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "Length",
                              subtitle: length + " Ft.",
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "Breath",
                              subtitle: width + " Ft.",
                            ),
                            const Divider(
                              color: kBottomNavigationBackgroundColor,
                              thickness: 1,
                            ),
                            specifications(
                              title: "Price",
                              subtitle: "Rs " + price,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const button(
                          title: 'Browse More',
                        ),
                        // const Spacer(),
                        const button(
                          title: 'Contact Buyer',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  final String title;
  const button({required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pushNamed(context, raiseAnIssue.id);
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            // fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: title == 'Contact Buyer' ? 10 : 5,
          backgroundColor: title == 'Contact Buyer'
              ? kHighlightedTextColor
              : kBottomNavigationBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
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
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            // padding: const EdgeInsets.all(3),
            width: (MediaQuery.of(context).size.width / 2) - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: kHighlightedTextColor,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: kBottomNavigationBackgroundColor,
            thickness: 1,
          ),
          SizedBox(
            // padding: const EdgeInsets.all(3),
            width: (MediaQuery.of(context).size.width / 2) - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: kHighlightedTextColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
