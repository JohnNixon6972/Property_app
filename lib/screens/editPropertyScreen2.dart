import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:property_app/screens/addPropertiesScreen2.dart';
import 'dart:io';
import 'myPropertiesScreen.dart';
import 'editPropertyScreen1.dart';
import 'package:property_app/storage_service.dart';
import '../constants.dart';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../storage_service.dart';

class editPropertyScreen2 extends StatefulWidget {
  myProperty propertyToEdit;
  editPropertyScreen2({required this.propertyToEdit});
  @override
  State<editPropertyScreen2> createState() => _editPropertyScreen2State();
}

late String PropertyDescription = "";
late String plotArea = "";
late String constructionArea = "";
late String lenght = "";
late String width = "";
late String cent = "";
late String BedRoom = "";
late String BathRoom = "";
late String Price = "";
late String face = "";
late String state = "";
late String district = "";
var _controller = TextEditingController();
TextEditingController _areaController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _bedRoomController = TextEditingController();
TextEditingController _bathRoomController = TextEditingController();
TextEditingController _constructionAreaController = TextEditingController();
TextEditingController _lenghtController = TextEditingController();
TextEditingController _widthController = TextEditingController();
TextEditingController _centController = TextEditingController();
late int selectedFace;
List<String> directions = ["North", "South", "East", "West"];

List<XFile>? imageFileList = [];
late bool isLand;

void readDetails(myProperty propertyToEdit) {
  selectedFace = directions.indexOf(propertyToEdit.face);
  isLand = propertyToEdit.propertyCategory == "Land" ||
      propertyToEdit.propertyCategory == "Plot";
  print(selectedFace);
  face = propertyToEdit.face;
  PropertyDescription = propertyToEdit.propertyDescription;
  plotArea = propertyToEdit.area;
  BedRoom = propertyToEdit.bedRoom;
  Price = propertyToEdit.price;
  BathRoom = propertyToEdit.bathRoom;
  district = propertyToEdit.district;
  constructionArea = propertyToEdit.constructionArea;
  _controller.text = propertyToEdit.propertyDescription;
  _areaController.text = propertyToEdit.area;
  _priceController.text = propertyToEdit.price;
  _bedRoomController.text = propertyToEdit.bedRoom;
  _bathRoomController.text = propertyToEdit.bathRoom;
  _lenghtController.text = propertyToEdit.lenght;
  _widthController.text = propertyToEdit.width;
  _centController.text = propertyToEdit.cent;
  _constructionAreaController.text = propertyToEdit.constructionArea;
}

class _editPropertyScreen2State extends State<editPropertyScreen2> {
  final ImagePicker imagePicker = ImagePicker();
  _editPropertyScreen2State();
  @override
  void initState() {
    // TODO: implement initState
    readDetails(widget.propertyToEdit);
    imageFileList = [];
    super.initState();
  }

  Future<void> selectImages() async {
    List<XFile>? selectedImages = null;

    selectedImages = await imagePicker.pickMultiImage(imageQuality: 80);
    if (selectedImages == null) {
      return;
    }
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      print("Image List Length:" + imageFileList!.length.toString());
      setState(() {});
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

  Widget buildListView() {
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: imageFileList!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          // return Image.file(
          //   File(imageFileList![index].path),
          //   fit: BoxFit.cover,
          // );
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(imageFileList![index].path),
                    height: 80,
                    fit: BoxFit.fill,
                    width: 80,
                    // child: ,
                  ),
                ),
                Positioned(
                    left: 60,
                    top: -5,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          imageFileList!.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: kHighlightedTextColor,
                        size: 25,
                      ),
                    ))
              ],
            ),
          );
        });
  }

  bool isloading = false;
  List<ImagesFromGallery> PickedImages = [];
  double _kItemExtent = 32.0;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: isloading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: kPageBackgroundColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(
                        child: Text(
                          "Please Wait until your add gets posted",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: kSubCategoryColor),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: kHighlightedTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          "You will be redirected once the add is posted",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kBottomNavigationBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.rotate(
                        angle: 270 * pi / 180,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.expand_less_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10.0),
                        child: Row(
                          children: const [
                            Text(
                              'Edit Property',
                              style: TextStyle(
                                  color: kHighlightedTextColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              'Step 2/2',
                              style: TextStyle(
                                  color: kSubCategoryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12),
                        child: DottedBorder(
                          color: kHighlightedTextColor,
                          radius: const Radius.circular(20),
                          borderType: BorderType.RRect,
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPropertyCardColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 14),
                              child: Row(
                                children: [
                                  const Text(
                                    'Upload Image',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  const Spacer(),
                                  AvatarGlow(
                                    glowColor: kHighlightedTextColor,
                                    endRadius: 25,
                                    duration:
                                        const Duration(milliseconds: 3000),
                                    repeat: true,
                                    // showTwoGlows: true,
                                    repeatPauseDuration:
                                        const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: selectImages,
                                      child: const CircleAvatar(
                                        backgroundColor: kPageBackgroundColor,
                                        child: const Icon(
                                          Icons.photo_library_sharp,
                                          color: kHighlightedTextColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Container(
                          height: 100,
                          child: buildListView(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 14),
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
                                const Text(
                                  'Write Property Description',
                                  style: TextStyle(color: kSubCategoryColor),
                                ),
                                TextField(
                                  onChanged: (newValue) {
                                    PropertyDescription = newValue;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  controller: _controller,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                  // minLines: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              PropertyDetailTile(
                                HintText: "Plot Area(SqFt.)",
                                onChange: (newValue) {
                                  setState(() {
                                    plotArea = newValue;
                                    // _areaController.text = newValue;
                                  });
                                },
                                currValue: plotArea,
                                textcontroller: _areaController,
                              ),
                              const Spacer(),
                              PropertyDetailTile(
                                HintText: "Building Area(SqFt.)",
                                onChange: (newValue) {
                                  setState(() {
                                    constructionArea = newValue;
                                    // _bedRoomController.text = newValue;
                                  });
                                },
                                currValue: BedRoom,
                                textcontroller: _constructionAreaController,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              !isLand
                                  ? Padding(
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
                                            onSelectedItemChanged:
                                                (int selectedItem) {
                                              setState(() {
                                                selectedFace = selectedItem;
                                                face = directions[selectedFace];
                                              });
                                            },
                                            children: List<Widget>.generate(
                                                directions.length, (int index) {
                                              return Center(
                                                child: Text(
                                                  directions[index],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        child: Container(
                                          height: 70,
                                          width: 165,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kHighlightedTextColor),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 20),
                                            child: Text(
                                              "Facing : " + face,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : PropertyDetailTile(
                                      HintText: "Width(Ft.)",
                                      onChange: (newValue) {
                                        setState(() {
                                          width = newValue;
                                          // _bathRoomController.text = newValue;
                                        });
                                      },
                                      currValue: width,
                                      textcontroller: _widthController,
                                    ),
                              const Spacer(),
                              !isLand
                                  ? PropertyDetailTile(
                                      textcontroller: _bedRoomController,
                                      currValue: BedRoom,
                                      HintText: "Bed Room",
                                      onChange: (newValue) {
                                        setState(() {
                                          BedRoom = newValue;
                                        });
                                      },
                                    )
                                  : PropertyDetailTile(
                                      textcontroller: _lenghtController,
                                      currValue: lenght,
                                      HintText: "Length",
                                      onChange: (newValue) {
                                        setState(() {
                                          lenght = newValue;
                                        });
                                      })
                            ],
                          ),
                          Row(
                            children: [
                              !isLand
                                  ? PropertyDetailTile(
                                      textcontroller: _bathRoomController,
                                      currValue: BathRoom,
                                      HintText: "Bathroom",
                                      onChange: (newValue) {
                                        setState(() {
                                          BathRoom = newValue;
                                        });
                                      },
                                    )
                                  : PropertyDetailTile(
                                      currValue: cent,
                                      textcontroller: _centController,
                                      HintText: "Cent",
                                      onChange: (newValue) {
                                        setState(() {
                                          cent = newValue;
                                        });
                                      }),
                              const Spacer(),
                              PropertyDetailTile(
                                textcontroller: _priceController,
                                currValue: Price,
                                HintText: "Price (INR)",
                                onChange: (newValue) {
                                  setState(() {
                                    Price = newValue;
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      // const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Storage _storage = Storage();
                              setState(
                                () {
                                  isloading = true;
                                  print("loading");
                                  String propertyAddress = PropertyAddress;
                                  String propertyTitle = PropertyTitle;
                                  String category = getCategory();
                                  String to = getTo();
                                  String type = getType();
                                  String propertyDescription =
                                      PropertyDescription;
                                  String PlotArea = plotArea;
                                  String bedRoom = BedRoom;
                                  String bathRoom = BathRoom;
                                  String price = Price;
                                  String Face = face;
                                  isloading = true;
                                  print("loading");
                                  _storage.uploadPropertyDetails(
                                      context,
                                      city,
                                      taluk,
                                      propertyAddress,
                                      propertyTitle,
                                      category,
                                      to,
                                      Face,
                                      type,
                                      propertyDescription,
                                      PlotArea,
                                      cent,
                                      lenght,
                                      width,
                                      _constructionAreaController.text,
                                      bedRoom,
                                      bathRoom,
                                      price,
                                      state,
                                      district,
                                      to == widget.propertyToEdit.to && true);
                                  _storage.uploadPropertyImages(context,
                                      imageFileList, propertyTitle, to, true);
                                },
                              );
                            },
                            child: Container(
                              height: 70,
                              width: 160,
                              decoration: BoxDecoration(
                                color: kHighlightedTextColor,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: const TextStyle(
                                      color: kSubCategoryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
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

class PropertyDetailTile extends StatelessWidget {
  final String HintText;
  final Function(String) onChange;
  final String currValue;
  final TextEditingController textcontroller;
  PropertyDetailTile(
      {required this.HintText,
      required this.onChange,
      required this.currValue,
      required this.textcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
      child: Container(
        height: 70,
        width: 165,
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textcontroller,
            onChanged: onChange,
            keyboardType: TextInputType.number,
            maxLines: 1,
            cursorColor: kHighlightedTextColor,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: HintText,
              hintStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class ImagesFromGallery extends StatelessWidget {
  final String img_url;
  ImagesFromGallery({required this.img_url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Stack(
        clipBehavior: Clip.none, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: AssetImage(img_url),
              height: 80,
              fit: BoxFit.fill,
              width: 80,
              // child: ,
            ),
          ),
          const Positioned(
              left: 60,
              top: -5,
              child: Icon(
                Icons.cancel,
                color: kHighlightedTextColor,
                size: 25,
              ))
        ],
      ),
    );
  }
}
