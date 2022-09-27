import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'package:property_app/components/loactionData.dart';
import 'package:property_app/main.dart';

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

final _firestore = FirebaseFirestore.instance;

class requestProperty extends StatefulWidget {
  // const requestProperty({Key? key}) : super(key: key);
  @override
  State<requestProperty> createState() => _requestPropertyState();
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: const Text(
                      'Request Property',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const Text(
                  'I want a Property to',
                  style: TextStyle(
                      color: kSubCategoryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 50,
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
                                    ? Border.all(color: kHighlightedTextColor)
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
                                    ? Border.all(color: kHighlightedTextColor)
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
                Center(
                  child: const Text(
                    'Property Type',
                    style: TextStyle(
                        color: kSubCategoryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 55,
                    child: Row(
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
                                    ? Border.all(color: kHighlightedTextColor)
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
                                    ? Border.all(color: kHighlightedTextColor)
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
                Center(
                  child: const Text(
                    'Select Category',
                    style: TextStyle(
                        color: kSubCategoryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 92,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: 100,
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: 100,
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: 100,
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: _category == propertyCategory.Apartment
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: 100,
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
                              children: List<Widget>.generate(districts!.length,
                                  (int index) {
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
                              border: Border.all(color: kHighlightedTextColor),
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
                              children: List<Widget>.generate(talukas.length,
                                  (int index) {
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
                              border: Border.all(color: kHighlightedTextColor),
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
                            border: Border.all(color: kHighlightedTextColor),
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
                            border: Border.all(color: kHighlightedTextColor),
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
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 6),
                          child: Container(
                            // height: 200,
                            // width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: kHighlightedTextColor),
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
                            // height: 100,
                            // width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: kHighlightedTextColor),
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                  child: Container(
                    height: 101,
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

                      onPressed: (_PropertyCityController
                                  .value.text.isNotEmpty &&
                              _PropertyPriceController.value.text.isNotEmpty)
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
        )
      ],
    );
  }
}
