import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:property_app/screens/addPropertiesScreen1.dart';
import 'package:property_app/screens/previewProperty.dart';
import 'package:property_app/storage_service.dart';

import '../constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../storage_service.dart';

class AddPropertiesScreen2 extends StatefulWidget {
  static const String id = 'addPropertiesScreen2';

  @override
  State<AddPropertiesScreen2> createState() => _AddPropertiesScreen2State();
}

late String PropertyDescription = "";
late String SquareFit = "";
late String BedRoom = "";
late String BathRoom = "";
late String Price = "";

List<XFile>? imageFileList = [];

class _AddPropertiesScreen2State extends State<AddPropertiesScreen2> {
  final ImagePicker imagePicker = ImagePicker();
  @override
  void initState() {
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

  // List<String> ImagePaths = [];
  List<ImagesFromGallery> PickedImages = [];

  var _controller = TextEditingController();

  bool isloading = false;
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
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.rotate(
                        angle: 270 * pi / 180,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddPropertiesScreen.id);
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
                          children: [
                            const Text(
                              'Add Properties',
                              style: TextStyle(
                                  color: kHighlightedTextColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            const Text(
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
                                    style: TextStyle(
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
                                        child: Icon(
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Container(
                            height: 100,
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
                                HintText: "Square Fit",
                                onChange: (newValue) {
                                  setState(() {
                                    SquareFit = newValue;
                                  });
                                },
                              ),
                              const Spacer(),
                              PropertyDetailTile(
                                HintText: "Bed Room",
                                onChange: (newValue) {
                                  setState(() {
                                    BedRoom = newValue;
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              PropertyDetailTile(
                                HintText: "Bathroom",
                                onChange: (newValue) {
                                  setState(() {
                                    BathRoom = newValue;
                                  });
                                },
                              ),
                              const Spacer(),
                              PropertyDetailTile(
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
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PreviewProperty(
                                              imageFileList: imageFileList,
                                              PropertyTitle: PropertyTitle,
                                              PropertyAddress: PropertyAddress,
                                              PropertyDescription:
                                                  PropertyDescription,
                                              Area: SquareFit,
                                              BathRoom: BathRoom,
                                              BedRoom: BedRoom,
                                              Price: Price,
                                              to: getTo())));
                                },
                                child: Container(
                                  height: 70,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: kNavigationIconColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: const Center(
                                    child: Text('Preview',
                                        style: TextStyle(
                                            color: kHighlightedTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Storage _storage = Storage();
                                  setState(() {
                                    isloading = true;
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
                                        false);
                                    _storage.uploadPropertyImages(
                                        context,
                                        imageFileList,
                                        propertyTitle,
                                        to,
                                        false);
                                  });
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
                                      'Submit',
                                      style: TextStyle(
                                          color: kSubCategoryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  isloading
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                      "Please Wait until your add gets posted"),
                                ),
                                const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ]),
              ),
      ),
    );
  }
}

class PropertyDetailTile extends StatelessWidget {
  final String HintText;
  final Function(String) onChange;
  PropertyDetailTile({required this.HintText, required this.onChange});

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
