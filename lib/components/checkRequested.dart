import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/requestPropertyDetails.dart';

class checkRequested extends StatefulWidget {
  const checkRequested({Key? key}) : super(key: key);

  @override
  State<checkRequested> createState() => _checkRequestedState();
}

class _checkRequestedState extends State<checkRequested> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width - 16,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                      border: Border.all(
                        color: kNavigationIconColor,
                      ),
                      color: kBottomNavigationBackgroundColor,
                    ),
                  ),
                  Container(
                    // height: 10,
                    // width: MediaQuery.of(context).size.width - 16,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        border: Border.all(
                          color: kHighlightedTextColor,
                        ),
                        color: kSecondaryButtonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.crop_square,
                                    size: 100,
                                    color: kHighlightedTextColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "City Name,",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kHighlightedTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Taluk Name.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kHighlightedTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: null,
                                            radius: 25,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: CachedNetworkImage(
                                                // cacheManager: customCacheManager,
                                                key: UniqueKey(),
                                                imageUrl:
                                                    userInfo.profileImgUrl,
                                                height: 50,
                                                width: 50,
                                                // maxHeightDiskCache: 230,
                                                // maxWidthDiskCache: 190,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        kHighlightedTextColor,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  color: Colors.black12,
                                                  child: const Icon(
                                                    Icons.error,
                                                    color:
                                                        kHighlightedTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "ownerName",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: kHighlightedTextColor),
                                          ),
                                        ],
                                      ),
                                      // const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              EmailContent email = EmailContent(
                                                to: [
                                                  "ownerMail",
                                                ],
                                              );

                                              OpenMailAppResult result =
                                                  await OpenMailApp
                                                      .composeNewEmailInMailApp(
                                                          nativePickerTitle:
                                                              'Select email app to compose',
                                                          emailContent: email);
                                              if (!result.didOpen &&
                                                  !result.canOpen) {
                                                // showNoMailAppsDialog(context);
                                              } else if (!result.didOpen &&
                                                  result.canOpen) {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      MailAppPickerDialog(
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
                                              var url = 'tel:' +
                                                  "ownerPhoneNo".toString();
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
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
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 135,
                    right: 20,
                    child: Transform.rotate(
                      angle: 315 * pi / 180,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, requestPropertyDetails.id);
                        },
                        child: const Icon(
                          Icons.send,
                          size: 45,
                          color: kHighlightedTextColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
