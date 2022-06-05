import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'editPropertyScreen2.dart';
import 'myPropertiesScreen.dart';
import '../constants.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/loactionData.dart';

enum propertyTo { Sell, Rent }
enum propertyType { Residental, Commercial }
enum propertyCategory { Plot, Land, House, Apartment, Building }

propertyTo? _to;

propertyCategory? _category;

propertyType? _type;

class EditPropertyScreen1 extends StatefulWidget {
  final myProperty propertyToEdit;
  EditPropertyScreen1({required this.propertyToEdit});

  @override
  State<EditPropertyScreen1> createState() =>
      _EditPropertyScreen1State(propertyToEdit: propertyToEdit);
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
late String state = "";
late String district = "";
late String city = "";
late String taluk = "";
List<String>? districts = Districts['Tamil Nadu'];
int selectedState = 0;
List<String>? talukas = [];

bool isSelectedState = false;
int selectedDistrict = 0;
int selectedTaluk = 0;
void readDetails(myProperty propertyToEdit, List<String> States,
    Map<String, List<String>> Districts) {
  _to = propertyToEdit.to == "Sell" ? propertyTo.Sell : propertyTo.Rent;
  print(propertyToEdit.propertyCategory);
  if (propertyToEdit.propertyCategory == "House") {
    _category = propertyCategory.House;
  } else if (propertyToEdit.propertyCategory == "Land") {
    _category = propertyCategory.Land;
  } else if (propertyToEdit.propertyCategory == "Plot") {
    _category = propertyCategory.Plot;
  } else if (propertyToEdit.propertyCategory == "Apartment") {
    _category = propertyCategory.Apartment;
  } else {
    _category = propertyCategory.Building;
  }
  state = propertyToEdit.state;
  city = propertyToEdit.city;
  taluk = propertyToEdit.taluk;
  district = propertyToEdit.district;
  selectedDistrict = Districts['Tamil Nadu']!.indexOf(district);
  selectedState = States.indexOf(state);
  selectedTaluk = Taluka[district]!.indexOf(taluk);
  talukas = Taluka[district];
  PropertyTitle = propertyToEdit.propertyName;
  PropertyAddress = propertyToEdit.propertyAddress;

  _type = propertyToEdit.propertyType == "Residental"
      ? propertyType.Residental
      : propertyType.Commercial;

  _PropertyAddressController.text = propertyToEdit.propertyAddress;
  _PropertyTitleController.text = propertyToEdit.propertyName;
  _PropertyCityController.text = propertyToEdit.city;
}

final _PropertyTitleController = TextEditingController();
final _PropertyAddressController = TextEditingController();
final _PropertyCityController = TextEditingController();

class _EditPropertyScreen1State extends State<EditPropertyScreen1> {
  String? get _errorText {
    final _selectedcity = _PropertyCityController.value.text;
    final _selectedaddress = _PropertyAddressController.value.text;
    final _selectedtitle = _PropertyTitleController.value.text;
    if (_selectedcity.isEmpty ||
        _selectedaddress.isEmpty ||
        _selectedtitle.isEmpty) {
      return 'Required*';
    }
    return null;
  }

  void push() {
    // if there is no error text
    if (district == "" || taluk == "") {
      popUpAlertDialogBox(context, "Kindly select District and Taluk");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  editPropertyScreen2(propertyToEdit: propertyToEdit)));
    }
  }

  myProperty propertyToEdit;
  _EditPropertyScreen1State({required this.propertyToEdit});
  @override
  void initState() {
    // TODO: implement initState
    readDetails(propertyToEdit, States, Districts);

    super.initState();
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

  bool uselastusedaddress = false;
  final _auth = FirebaseAuth.instance;
  final _firstore = FirebaseFirestore.instance;
  double _kItemExtent = 32.0;
  @override
  Widget build(BuildContext context) {
    void setTaluka(List<String>? talukstobeset) {
      setState(() {
        talukas = talukstobeset!;
        selectedTaluk = 0;
        taluk = "";
      });
    }

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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
                  child: Row(
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
                      Text(
                        'Edit Property',
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
                            ),
                            // Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 100,
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
                            ),
                            // Spacer(),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 100,
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
                          Padding(
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
                                      print(district);
                                    });
                                  },
                                  children: List<Widget>.generate(
                                      districts!.length, (int index) {
                                    print(districts);
                                    return Center(
                                      child: Text(
                                        districts![index],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              child: Container(
                                height: 60,
                                width: 155,
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
                          Padding(
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
                                      taluk = talukas![selectedTaluk];
                                      print(taluk);
                                    });
                                  },
                                  children: List<Widget>.generate(
                                      talukas!.length, (int index) {
                                    print(talukas);
                                    return Center(
                                      child: Text(
                                        talukas![index],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              child: Container(
                                height: 60,
                                width: 155,
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
                          )
                        ],
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: _errorText),
                            // controller: _controller,
                            controller: _PropertyTitleController,
                            onChanged: (newValue) {
                              setState(() {
                                PropertyTitle = newValue;
                              });
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
                                setState(() {
                                  PropertyAddress = newValue;
                                });
                              },
                              controller: _PropertyAddressController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: _errorText,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 200,
                        width: 200,
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
                                border: InputBorder.none,
                                errorText: _errorText,
                                hintText: "City",
                                hintStyle: TextStyle(color: kSubCategoryColor)),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            // only enable the button if the text is not empty

                            onPressed: (_PropertyAddressController
                                        .value.text.isNotEmpty &&
                                    _PropertyCityController
                                        .value.text.isNotEmpty &&
                                    _PropertyTitleController
                                        .value.text.isNotEmpty)
                                ? push
                                : null,
                            child: const Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: kPrimaryButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        )
                        // Center(
                        //   child: CircleAvatar(
                        //     radius: 35,
                        //     backgroundColor: kTextFieldFillColor,
                        //     child: Transform.rotate(
                        //       angle: 90 * pi / 180,
                        //       child: GestureDetector(
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       editPropertyScreen2(
                        //                           propertyToEdit:
                        //                               propertyToEdit)));
                        //         },
                        //         child: Icon(
                        //           Icons.expand_less_rounded,
                        //           color: kHighlightedTextColor,
                        //           size: 70,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
