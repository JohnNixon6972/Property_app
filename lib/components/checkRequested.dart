import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/components/requestProperty.dart';
import 'package:property_app/constants.dart';
import 'package:property_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/requestPropertyDetails.dart';

class checkRequested extends StatefulWidget {
  const checkRequested({Key? key}) : super(key: key);

  @override
  State<checkRequested> createState() => _checkRequestedState();
}

const icons_data = {
  "Plot": Icons.crop_square,
  "Land": Icons.landscape_outlined,
  "House": Icons.house_outlined,
  "Building": Icons.room_preferences_outlined,
  "Apartment": Icons.apartment
};

class _checkRequestedState extends State<checkRequested> {
  Stream collectionStream =
      FirebaseFirestore.instance.collection('RequestedProperties').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot requestedProperty = snapshot.data!.docs[index];
                IconData icon;
                String ownerName,
                    length,
                    width,
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
                    ownerEmail;

                icon = icons_data[requestedProperty['PropertyCategory']]!;
                ownerName = requestedProperty['OwnerName'];
                city = requestedProperty['City'];
                taluk = requestedProperty['Taluk'];
                to = requestedProperty['PropertyTo'];
                category = requestedProperty['PropertyCategory'];
                type = requestedProperty['PropertyType'];
                price = requestedProperty['Price'];
                ownerPhno = requestedProperty['PhNo'];
                ownerimg = requestedProperty['profileImgUrl'];
                state = requestedProperty['State'];
                district = requestedProperty['District'];
                description = requestedProperty['description'];
                ownerEmail = requestedProperty['PropertyBy'];
                length = requestedProperty["Length"];
                width = requestedProperty["Width"];

                return RequestedProperty(
                    length: length,
                    width: width,
                    category: category,
                    ownerName: ownerName,
                    taluk: taluk,
                    city: city,
                    to: to,
                    type: type,
                    price: price,
                    ownerPhno: ownerPhno,
                    ownerimg: ownerimg,
                    state: state,
                    district: district,
                    description: description,
                    icon: icon,
                    ownerEmail: ownerEmail);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        stream: collectionStream);
  }
}

class RequestedProperty extends StatelessWidget {
  IconData icon;
  String ownerName,
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
  RequestedProperty(
      {Key? key,
      required this.length,
      required this.width,
      required this.category,
      required this.ownerName,
      required this.taluk,
      required this.city,
      required this.to,
      required this.type,
      required this.price,
      required this.ownerPhno,
      required this.ownerimg,
      required this.state,
      required this.district,
      required this.description,
      required this.icon,
      required this.ownerEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
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
                        children: [
                          Icon(
                            icon,
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
                          Text(
                            "City : " + city,
                            style: const TextStyle(
                              fontSize: 20,
                              color: kHighlightedTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Taluk : " + taluk,
                            style: const TextStyle(
                              fontSize: 20,
                              color: kHighlightedTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                                      
                                      borderRadius: BorderRadius.circular(25),
                                      child: CachedNetworkImage(
                                        // cacheManager: customCacheManager,
                                        key: UniqueKey(),
                                        imageUrl: ownerimg,
                                        height: 50,
                                        width: 50,
                                        // maxHeightDiskCache: 230,
                                        // maxWidthDiskCache: 190,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            color: kHighlightedTextColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.black12,
                                          child: const Icon(
                                            Icons.error,
                                            color: kHighlightedTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ownerName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: kHighlightedTextColor),
                                  ),
                                ],
                              ),
                              // const Spacer(),
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

                                      OpenMailAppResult result = await OpenMailApp
                                          .composeNewEmailInMailApp(
                                              nativePickerTitle:
                                                  'Select email app to compose',
                                              emailContent: email);
                                      if (!result.didOpen && !result.canOpen) {
                                        // showNoMailAppsDialog(context);
                                      } else if (!result.didOpen &&
                                          result.canOpen) {
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
                                      var url = 'tel:' + ownerPhno.toString();
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.175,
            right: 28,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => requestPropertyDetails(
                            length: length,
                            width: width,
                            category: category,
                            ownerName: ownerName,
                            taluk: taluk,
                            city: city,
                            to: to,
                            type: type,
                            price: price,
                            ownerPhno: ownerPhno,
                            ownerimg: ownerimg,
                            state: state,
                            district: district,
                            description: description,
                            icon: icon,
                            ownerEmail: ownerEmail)));
              },
              child: const Icon(
                Icons.content_paste_go,
                size: 45,
                color: kHighlightedTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
