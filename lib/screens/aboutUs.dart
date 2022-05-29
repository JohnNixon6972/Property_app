// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'dart:math';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: camel_case_types
class aboutUs extends StatefulWidget {
  static const id = 'aboutUs';

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  List<Widget> profiles() {
    return admin == true
        ? [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image: AssetImage("./images/profile_img1.jpg"),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "Admin",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Pleasant Properties Admin",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              EmailContent email = EmailContent(
                                to: [
                                  'admin@gmail.com',
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
                              var url = 'tel:6363850983';
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
                  const Spacer()
                ],
              ),
            ),
          ]
        : [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: const Image(
                      image: AssetImage("./images/profile_img1.jpg"),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "Hrutuja Patnekar",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Developer and Designer",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              EmailContent email = EmailContent(
                                to: [
                                  'hrutujapatnekar22@gmail.com',
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
                        ],
                      )
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: const Image(
                      image: AssetImage("./images/profile_img1.jpg"),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "John Nixon",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Developer",
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              EmailContent email = EmailContent(
                                to: [
                                  'johnbrightnixon@gmail.com',
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
                              var url = 'tel:6363850983';
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
                  const Spacer(),
                ],
              ),
            )
          ];
  }

  bool admin = false;
  bool developers = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        size: 50,
                        color: kHighlightedTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const Center(
                    child: Text(
                      'About Us',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: kHighlightedTextColor),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                indent: 50,
                endIndent: 50,
                color: kHighlightedTextColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Admin",
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      activeColor: kBottomNavigationBackgroundColor,
                      inactiveColor: kNavigationIconColor,
                      width: 70.0,
                      height: 35.0,
                      // valueFontSize: 25.0,
                      toggleSize: 25.0,
                      value: admin,
                      borderRadius: 30.0,
                      padding: 8.0,
                      // showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          admin = val;
                          developers = !val;
                          // val1 = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Developers",
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      activeColor: kBottomNavigationBackgroundColor,
                      inactiveColor: kNavigationIconColor,
                      width: 70.0,
                      height: 35.0,
                      // valueFontSize: 25.0,
                      toggleSize: 25.0,
                      value: developers,
                      borderRadius: 30.0,
                      padding: 8.0,
                      // showOnOff: true,
                      onToggle: (val1) {
                        setState(() {
                          developers = val1;
                          admin = !val1;
                          // val = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: kHighlightedTextColor,
              ),
              Column(
                children: profiles(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
