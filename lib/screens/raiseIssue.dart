// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print, file_names, constant_identifier_names, prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'package:property_app/components/loactionData.dart';
import 'package:property_app/main.dart';
import 'package:property_app/screens/requestPropertyDetails.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:badges/badges.dart';

import '../constants.dart';

enum propertyTo { Buy, Rent }

enum propertyType { Residental, Commercial }

enum propertyCategory { Plot, Land, House, Apartment, Building }

propertyTo? _to = propertyTo.Buy;

propertyCategory? _category = propertyCategory.Plot;

propertyType? _type = propertyType.Residental;

late String PropertyTitle = "";
late String PropertyAddress = "";
late String state = "";
late String district = "";
late String taluk = "";
late String city = "";
late String price = "";
late String length = "";
late String width = "";
late String PropertyDescription = "";

final _firestore = FirebaseFirestore.instance;
bool idx = true;

class raiseAnIssue extends StatefulWidget {
  static const id = 'raiseAnIssue';

  @override
  State<raiseAnIssue> createState() => _raiseAnIssueState();
}

class _raiseAnIssueState extends State<raiseAnIssue> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 141,
          actions: [
            ToggleSwitch(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: 70,
              initialLabelIndex: idx ? 0 : 1,
              totalSwitches: 2,
              cornerRadius: 0,
              isVertical: true,
              activeBgColor: const [kBottomNavigationBackgroundColor],
              inactiveBgColor: kNavigationIconColor,
              activeBorders: [
                Border.all(color: kHighlightedTextColor, width: 2),
              ],
              activeFgColor: kHighlightedTextColor,
              inactiveFgColor: kHighlightedTextColor,
              fontSize: 18,
              iconSize: 25,
              labels: const ["Request Property", "Check Requests"],
              icons: const [Icons.back_hand, Icons.comment_bank_rounded],
              onToggle: ((index) {
                print(index);
                setState(() {
                  idx = !idx;
                });
              }),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: requestProperty(),
        ),
      ),
    );
  }
}

class requestProperty extends StatefulWidget {
  // const requestProperty({Key? key}) : super(key: key);

  @override
  State<requestProperty> createState() => _requestPropertyState();
}

String getCategory() {
  if (_category == propertyCategory.Apartment) {
    return "Apartment";
  } else if (_category == propertyCategory.Building) {
    return "Building";
  } else if (_category == propertyCategory.Plot) {
    return "Plot";
  } else if (_category == propertyCategory.Land) {
    return "Land";
  } else {
    return "House";
  }
}

String getType() {
  if (_type == propertyType.Commercial) {
    return "Commercial";
  } else {
    return "Residental";
  }
}

String getTo() {
  if (_to == propertyTo.Rent) {
    return "Rent";
  } else {
    return "Buy";
  }
}

class _requestPropertyState extends State<requestProperty> {
  final _PropertyCityController = TextEditingController();
  final _PropertyPriceController = TextEditingController();
  void push() {
    // if there is no error text
    if (district == "" || taluk == "") {
      popUpAlertDialogBox(context, "Kindly select District and Taluk");
    } else {
      setState(() {
        String category = getCategory();
        String to = getTo();
        String type = getType();

        _firestore
            .collection("Users")
            .doc(userInfo.mobileNumber)
            .collection("My requests")
            .add({
          // "PropertyBy": userInfo.email,
          "OwnerName": userInfo.name,
          "City": city,
          "Taluk": taluk,
          "PropertyTo": to,
          "PropertyCategory": category,
          "PropertyType": type,
          "isSetImages": "False",
          "Price": price,
          "PhNo": userInfo.mobileNumber,
          "profileImgUrl": userInfo.profileImgUrl,
          "State": 'Tamil Nadu',
          "District": district,
        }).then((_) {
          print("Data Added Sucessfully");
        }).catchError((e) {
          print(e);
        });
      });
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  String? get _errorText {
    final _selectedcity = _PropertyCityController.value.text;
    final _selectedPrice = _PropertyPriceController.value.text;

    if (_selectedcity.isEmpty) {
      return 'Required*';
    }
    if (_selectedPrice.isEmpty) {
      return 'Required*';
    }
    return null;
  }

  @override
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  int selectedDistrict = 0;
  List<String> talukas = [];
  Widget build(BuildContext context) {
    List<String>? districts = Districts['Tamil Nadu'];
    double _kItemExtent = 32.0;
    int selectedTaluk = 0;
    void setTaluka(List<String>? talukstobeset) {
      setState(() {
        talukas = talukstobeset!;
        selectedTaluk = 0;
        taluk = "";
      });
    }

    return idx == true
        ? Column(
            children: [
              const Text(
                'Request Property',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kHighlightedTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'I want a Property to',
                      style: TextStyle(
                          color: kSubCategoryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 65,
                        child: Row(
                          // physics: const BouncingScrollPhysics(),
                          // // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // scrollDirection: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  // width: 160,
                                  decoration: BoxDecoration(
                                    border: _to == propertyTo.Buy
                                        ? Border.all(
                                            color: kHighlightedTextColor)
                                        : null,
                                    borderRadius: BorderRadius.circular(15),
                                    color: _to == propertyTo.Buy
                                        ? kPropertyCardColor
                                        : kTextFieldFillColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Buy',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Radio(
                                          value: propertyTo.Buy,
                                          activeColor: kHighlightedTextColor,
                                          groupValue: _to,
                                          onChanged: (propertyTo? value) {
                                            setState(() {
                                              _to = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  // width: 160,
                                  decoration: BoxDecoration(
                                    border: _to == propertyTo.Rent
                                        ? Border.all(
                                            color: kHighlightedTextColor)
                                        : null,
                                    color: _to == propertyTo.Rent
                                        ? kPropertyCardColor
                                        : kTextFieldFillColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Rent',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Radio(
                                          value: propertyTo.Rent,
                                          activeColor: kHighlightedTextColor,
                                          groupValue: _to,
                                          onChanged: (propertyTo? value) {
                                            setState(() {
                                              _to = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Properties Type',
                      style: TextStyle(
                          color: kSubCategoryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 75,
                        child: Row(
                          // physics: const BouncingScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Container(
                                  // width: 165,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: _type == propertyType.Residental
                                        ? Border.all(
                                            color: kHighlightedTextColor)
                                        : null,
                                    color: _type == propertyType.Residental
                                        ? kPropertyCardColor
                                        : kTextFieldFillColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Residental',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Radio(
                                          activeColor: kHighlightedTextColor,
                                          value: propertyType.Residental,
                                          groupValue: _type,
                                          onChanged: (propertyType? value) {
                                            setState(() {
                                              _type = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Spacer(),

                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Container(
                                  // width: 165,
                                  decoration: BoxDecoration(
                                    border: _type == propertyType.Commercial
                                        ? Border.all(
                                            color: kHighlightedTextColor)
                                        : null,
                                    color: _type == propertyType.Commercial
                                        ? kPropertyCardColor
                                        : kTextFieldFillColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Commercial',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Radio(
                                          activeColor: kHighlightedTextColor,
                                          value: propertyType.Commercial,
                                          groupValue: _type,
                                          onChanged: (propertyType? value) {
                                            setState(() {
                                              _type = value;
                                              print(_type);
                                            });
                                          },
                                        )
                                      ],
                                    ),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Category',
                      style: TextStyle(
                          color: kSubCategoryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 100,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: _category == propertyCategory.Plot
                                      ? Border.all(color: kHighlightedTextColor)
                                      : null,
                                  color: _category == propertyCategory.Plot
                                      ? kPropertyCardColor
                                      : kTextFieldFillColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(
                                            Icons.crop_square,
                                            size: 50,
                                            color: kHighlightedTextColor,
                                          ),
                                          Text('Plot')
                                        ],
                                      ),
                                      Radio(
                                        value: propertyCategory.Plot,
                                        activeColor: kHighlightedTextColor,
                                        groupValue: _category,
                                        onChanged: (propertyCategory? value) {
                                          setState(() {
                                            _category = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: _category == propertyCategory.Land
                                      ? Border.all(color: kHighlightedTextColor)
                                      : null,
                                  color: _category == propertyCategory.Land
                                      ? kPropertyCardColor
                                      : kTextFieldFillColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(
                                            Icons.landscape_outlined,
                                            size: 50,
                                            color: kHighlightedTextColor,
                                          ),
                                          Text('Land')
                                        ],
                                      ),
                                      Radio(
                                        value: propertyCategory.Land,
                                        activeColor: kHighlightedTextColor,
                                        groupValue: _category,
                                        onChanged: (propertyCategory? value) {
                                          setState(() {
                                            _category = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: _category == propertyCategory.House
                                      ? Border.all(color: kHighlightedTextColor)
                                      : null,
                                  color: _category == propertyCategory.House
                                      ? kPropertyCardColor
                                      : kTextFieldFillColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(
                                            Icons.house_outlined,
                                            size: 50,
                                            color: kHighlightedTextColor,
                                          ),
                                          Text('House')
                                        ],
                                      ),
                                      Radio(
                                        value: propertyCategory.House,
                                        activeColor: kHighlightedTextColor,
                                        groupValue: _category,
                                        onChanged: (propertyCategory? value) {
                                          setState(() {
                                            _category = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: _category ==
                                          propertyCategory.Apartment
                                      ? Border.all(color: kHighlightedTextColor)
                                      : null,
                                  color: _category == propertyCategory.Apartment
                                      ? kPropertyCardColor
                                      : kTextFieldFillColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(
                                            Icons.apartment,
                                            size: 50,
                                            color: kHighlightedTextColor,
                                          ),
                                          Text('Apartment')
                                        ],
                                      ),
                                      Radio(
                                        value: propertyCategory.Apartment,
                                        activeColor: kHighlightedTextColor,
                                        groupValue: _category,
                                        onChanged: (propertyCategory? value) {
                                          setState(() {
                                            _category = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: _category == propertyCategory.Building
                                      ? Border.all(color: kHighlightedTextColor)
                                      : null,
                                  color: _category == propertyCategory.Building
                                      ? kPropertyCardColor
                                      : kTextFieldFillColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(
                                            Icons.room_preferences_outlined,
                                            size: 50,
                                            color: kHighlightedTextColor,
                                          ),
                                          Text('Building')
                                        ],
                                      ),
                                      Radio(
                                        value: propertyCategory.Building,
                                        activeColor: kHighlightedTextColor,
                                        groupValue: _category,
                                        onChanged: (propertyCategory? value) {
                                          setState(() {
                                            _category = value;
                                            print(_type);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Select Area',
                          style: TextStyle(
                              color: kSubCategoryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Text(
                          'State : Tamil Nadu',
                          style: TextStyle(
                              color: kSubCategoryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: GestureDetector(
                              onTap: () => _showDialog(
                                CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: _kItemExtent,
                                  // This is called when selected item is changed.
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      selectedDistrict = selectedItem;
                                      district = districts![selectedDistrict];
                                      setTaluka(Taluka[district]);
                                    });
                                  },
                                  children: List<Widget>.generate(
                                      districts!.length, (int index) {
                                    print(districts);
                                    return Center(
                                      child: Text(
                                        districts[index],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              child: Container(
                                height: 60,
                                // width: 155,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: kHighlightedTextColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Text(
                                    "District : " + district,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: GestureDetector(
                              onTap: () => _showDialog(
                                CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: _kItemExtent,
                                  // This is called when selected item is changed.
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      selectedTaluk = selectedItem;
                                      taluk = talukas[selectedTaluk];
                                      print(taluk);
                                    });
                                  },
                                  children: List<Widget>.generate(
                                      talukas.length, (int index) {
                                    print(talukas);
                                    return Center(
                                      child: Text(
                                        talukas[index],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              child: Container(
                                height: 60,
                                // width: 155,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: kHighlightedTextColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Text(
                                    "Taluka : " + taluk,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: Container(
                              // height: 200,
                              // width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kHighlightedTextColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (newValue) {
                                    setState(() {
                                      length = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      // errorText: _errorText,
                                      border: InputBorder.none,
                                      hintText: "East-West(Ft.)",
                                      hintStyle: const TextStyle(
                                          color: kSubCategoryColor)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: Container(
                              // height: 200,
                              // width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kHighlightedTextColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (newValue) {
                                    setState(() {
                                      price = newValue;
                                    });
                                  },
                                  // controller: _PropertyPriceController,
                                  decoration: InputDecoration(
                                      // errorText: _errorText,
                                      border: InputBorder.none,
                                      hintText: "North-South(Ft.)",
                                      hintStyle: const TextStyle(
                                          color: kSubCategoryColor)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: Container(
                              // height: 200,
                              // width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kHighlightedTextColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (newValue) {
                                    setState(() {
                                      city = newValue;
                                    });
                                  },
                                  controller: _PropertyCityController,
                                  decoration: InputDecoration(
                                      errorText: _errorText,
                                      border: InputBorder.none,
                                      hintText: "City",
                                      hintStyle: const TextStyle(
                                          color: kSubCategoryColor)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 6),
                            child: Container(
                              // height: 200,
                              // width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kHighlightedTextColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (newValue) {
                                    setState(() {
                                      price = newValue;
                                    });
                                  },
                                  controller: _PropertyPriceController,
                                  decoration: InputDecoration(
                                      errorText: _errorText,
                                      border: InputBorder.none,
                                      hintText: "Price",
                                      hintStyle: const TextStyle(
                                          color: kSubCategoryColor)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 14),
                      child: Container(
                        height: 121,
                        decoration: BoxDecoration(
                          border: Border.all(color: kHighlightedTextColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Write Property Description',
                                style: TextStyle(color: kSubCategoryColor),
                              ),
                              TextField(
                                onChanged: (newValue) {
                                  setState(() {
                                    PropertyDescription = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // errorText: _errorText,
                                ),
                                // controller: _controller,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                // minLines: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 50,
                        // width: 150,
                        child: ElevatedButton(
                          // only enable the button if the text is not empty

                          onPressed:
                              (_PropertyCityController.value.text.isNotEmpty &&
                                      _PropertyPriceController
                                          .value.text.isNotEmpty)
                                  ? push
                                  : null,
                          child: const Text(
                            'Submit Request',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: kPrimaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Expanded(
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
                                children: [
                                  Icon(
                                    Icons.crop_square,
                                    size: 100,
                                    color: kHighlightedTextColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "City Name,",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: kHighlightedTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Taluk Name.",
                                    style: const TextStyle(
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
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
                                              var url = 'tel:' +
                                                  "ownerPhoneNo".toString();
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
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
          );
  }
}
