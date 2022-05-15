import 'package:flutter/material.dart';
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
late String SquareFit = "";
late String BedRoom = "";
late String BathRoom = "";
late String Price = "";
var _controller = TextEditingController();
TextEditingController _areaController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _bedRoomController = TextEditingController();
TextEditingController _bathRoomController = TextEditingController();

List<XFile>? imageFileList = [];

void readDetails(myProperty propertyToEdit) {
  PropertyDescription = propertyToEdit.propertyDescription;
  SquareFit = propertyToEdit.area;
  BedRoom = propertyToEdit.bedRoom;
  Price = propertyToEdit.price;
  BathRoom = propertyToEdit.bathRoom;
  _controller.text = propertyToEdit.propertyDescription;
  _areaController.text = propertyToEdit.area;
  _priceController.text = propertyToEdit.price;
  _bedRoomController.text = propertyToEdit.bedRoom;
  _bathRoomController.text = propertyToEdit.bathRoom;
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
    final List<XFile>? selectedImages =
        await imagePicker.pickMultiImage(imageQuality: 80);
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      print("Image List Length:" + imageFileList!.length.toString());
      setState(() {});
    }
  }

  Widget buildListView() {
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
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
                      child: Icon(
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
                    children: [
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
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.rotate(
                        angle: 270 * pi / 180,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPropertyScreen1(
                                        propertyToEdit:
                                            widget.propertyToEdit)));
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
                          radius: Radius.circular(20),
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
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: selectImages,
                                    child: CircleAvatar(
                                      backgroundColor: kPageBackgroundColor,
                                      child: Icon(
                                        Icons.photo_library_sharp,
                                        color: kHighlightedTextColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Container(
                            child: buildListView(),
                          ),
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
                                Text(
                                  'Write Property Description',
                                  style: TextStyle(color: kSubCategoryColor),
                                ),
                                TextField(
                                  onChanged: (newValue) {
                                    PropertyDescription = newValue;
                                  },
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  controller: _controller,
                                  style: TextStyle(
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
                                HintText: "Square Fit",
                                onChange: (newValue) {
                                  setState(() {
                                    SquareFit = newValue;
                                    // _areaController.text = newValue;
                                  });
                                },
                                currValue: SquareFit,
                                textcontroller: _areaController,
                              ),
                              Spacer(),
                              PropertyDetailTile(
                                HintText: "Bed Room",
                                onChange: (newValue) {
                                  setState(() {
                                    BedRoom = newValue;
                                    // _bedRoomController.text = newValue;
                                  });
                                },
                                currValue: BedRoom,
                                textcontroller: _bedRoomController,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              PropertyDetailTile(
                                HintText: "Bathroom",
                                onChange: (newValue) {
                                  setState(() {
                                    BathRoom = newValue;
                                    // _bathRoomController.text = newValue;
                                  });
                                },
                                currValue: BathRoom,
                                textcontroller: _bathRoomController,
                              ),
                              Spacer(),
                              PropertyDetailTile(
                                HintText: "Price (USD)",
                                onChange: (newValue) {
                                  setState(() {
                                    Price = newValue;
                                    // _priceController.text = newValue;
                                  });
                                },
                                currValue: Price,
                                textcontroller: _priceController,
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Storage _storage = Storage();
                                setState(() {
                                  isloading = true;
                                  print("loading");
                                  String propertyAddress = PropertyAddress;
                                  String propertyTitle = PropertyTitle;
                                  String category = getCategory();
                                  String to = getTo();
                                  String type = getType();
                                  String propertyDescription =
                                      PropertyDescription;
                                  String squareFit = SquareFit;
                                  String bedRoom = BedRoom;
                                  String bathRoom = BathRoom;
                                  String price = Price;
                                  isloading = true;
                                  print("loading");
                                  _storage.uploadPropertyDetails(
                                      context,
                                      propertyAddress,
                                      propertyTitle,
                                      category,
                                      to,
                                      type,
                                      propertyDescription,
                                      squareFit,
                                      bedRoom,
                                      bathRoom,
                                      price,
                                      to == widget.propertyToEdit.to && true);
                                  _storage.uploadPropertyImages(context,
                                      imageFileList, propertyTitle, to, true);
                                });
                              },
                              child: Container(
                                height: 70,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: kHighlightedTextColor,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: kSubCategoryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: 160,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: HintText,
              hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
        overflow: Overflow.visible,
        children: [
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
          Positioned(
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
