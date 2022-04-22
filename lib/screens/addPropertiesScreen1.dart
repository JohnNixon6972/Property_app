import 'package:flutter/material.dart';
import 'package:property_app/screens/addPopertiesScreen2.dart';
import '../constants.dart';
import 'dart:math';

enum propertyTo { Sell, Rent }
enum propertyType { Residental, Commercial }
enum propertyCategory { Penthouse, Apartment, Building }

propertyTo? _to = propertyTo.Sell;

propertyCategory? _category = propertyCategory.Penthouse;

propertyType? _type = propertyType.Residental;

class AddPropertiesScreen extends StatefulWidget {
  static const String id = 'addPropertiesScreen';

  @override
  State<AddPropertiesScreen> createState() => _AddPropertiesScreenState();
}

class _AddPropertiesScreenState extends State<AddPropertiesScreen> {
  var _controller = TextEditingController();
  bool uselastusedaddress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.rotate(
                  angle: 270 * pi / 180,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
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
                            ),
                            // Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
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
                              ),
                            )
                          ],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
                            ),
                            // Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
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
                              ),
                            )
                          ],
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
                                    color:
                                        _category == propertyCategory.Penthouse
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
                                            Text('PentHouses')
                                          ],
                                        ),
                                        Radio(
                                          value: propertyCategory.Penthouse,
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
                            controller: _controller,
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
                Row(
                  children: [
                    Checkbox(
                      activeColor: kHighlightedTextColor,
                      //  fillColor: ,
                      value: uselastusedaddress,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            uselastusedaddress = value!;
                          },
                        );
                      },
                    ),
                    Text(
                      'Use last used address',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
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
                            color: Colors.black,
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
