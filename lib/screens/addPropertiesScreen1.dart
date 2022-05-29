import 'package:flutter/material.dart';
import 'package:property_app/screens/addPropertiesScreen2.dart';
import 'package:property_app/screens/homescreen.dart';
import '../constants.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum propertyTo { Sell, Rent }
enum propertyType { Residental, Commercial }
enum propertyCategory { Plot, Land, House, Apartment, Building }

propertyTo? _to = propertyTo.Sell;

propertyCategory? _category = propertyCategory.Plot;

propertyType? _type = propertyType.Residental;

class AddPropertiesScreen extends StatefulWidget {
  static const String id = 'addPropertiesScreen';

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
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
    return "Sell";
  }
}

late String PropertyTitle;
late String PropertyAddress;

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  var _PropertyTitleController = TextEditingController();
  var _PropertyAddressController = TextEditingController();
  bool uselastusedaddress = false;
  final _auth = FirebaseAuth.instance;
  final _firstore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.rotate(
                  angle: 270 * pi / 180,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
                    child: Icon(
                      Icons.expand_less_rounded,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Add Properties',
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        'Step 1/2',
                        style: TextStyle(
                            color: kSubCategoryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I want to',
                        style: TextStyle(
                            color: kSubCategoryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 75,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                    border: _to == propertyTo.Sell
                                        ? Border.all(
                                            color: kHighlightedTextColor)
                                        : null,
                                    borderRadius: BorderRadius.circular(15),
                                    color: _to == propertyTo.Sell
                                        ? kPropertyCardColor
                                        : kTextFieldFillColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Sell',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Radio(
                                          value: propertyTo.Sell,
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
                              // Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 160,
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
                                        Text(
                                          'Rent',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
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
                      Text(
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
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 165,
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Residental',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
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
                              // Spacer(),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 165,
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Commercial',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
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
                      Text(
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
                            physics: BouncingScrollPhysics(),
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
                                        ? Border.all(
                                            color: kHighlightedTextColor)
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
                                          children: [
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
                                        ? Border.all(
                                            color: kHighlightedTextColor)
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
                                          children: [
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
                                        ? Border.all(
                                            color: kHighlightedTextColor)
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
                                          children: [
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
                                    border:
                                        _category == propertyCategory.Apartment
                                            ? Border.all(
                                                color: kHighlightedTextColor)
                                            : null,
                                    color:
                                        _category == propertyCategory.Apartment
                                            ? kPropertyCardColor
                                            : kTextFieldFillColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
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
                                    border:
                                        _category == propertyCategory.Building
                                            ? Border.all(
                                                color: kHighlightedTextColor)
                                            : null,
                                    color:
                                        _category == propertyCategory.Building
                                            ? kPropertyCardColor
                                            : kTextFieldFillColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kHighlightedTextColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Write Property Title',
                            style: TextStyle(color: kSubCategoryColor),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            // controller: _controller,
                            controller: _PropertyTitleController,
                            onChanged: (newValue) {
                              PropertyTitle = newValue;
                            },
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            // minLines: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kHighlightedTextColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (newValue) {
                                PropertyAddress = newValue;
                              },
                              controller: _PropertyAddressController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Address",
                                  hintStyle:
                                      TextStyle(color: kSubCategoryColor)),
                            ),
                          ),
                          Icon(
                            Icons.add_location_outlined,
                            color: kHighlightedTextColor,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: kTextFieldFillColor,
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddPropertiesScreen2.id);
                          },
                          child: Icon(
                            Icons.expand_less_rounded,
                            color: kHighlightedTextColor,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
