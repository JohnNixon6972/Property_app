import 'dart:io';

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

late String propertyDescription = "";
late String squareFit = "";
late String bedRoom = "";
late String bathRoom = "";
late String price = "";

List<XFile>? imageFileList = [];

class _AddPropertiesScreen2State extends State<AddPropertiesScreen2> {
  final ImagePicker imagePicker = ImagePicker();

  Future<void> selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
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

  // List<String> ImagePaths = [];
  List<ImagesFromGallery> PickedImages = [];

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.rotate(
                angle: 270 * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AddPropertiesScreen.id);
                  },
                  child: Icon(
                    Icons.expand_less_rounded,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
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
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: selectImages,
                            // onTap: () async {
                            //   final result =
                            //       await FilePicker.platform.pickFiles(
                            //     type: FileType.custom,
                            //     allowedExtensions: ['png', 'jpg'],
                            //   );
                            //   if (result == null) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //             content: Text('No file Selected')));
                            //     return null;
                            //   }
                            //   final path = result.files.single.path;
                            //   final filename = result.files.single.name;

                            //   setState(() {
                            //     // ImageName.add(filename);
                            //     // ImagePaths.add(path!);
                            //     PickedImages.add(
                            //         ImagesFromGallery(img_url: path!));
                            //   });

                            //   print(path);
                            //   print(filename);
                            //   storage
                            //       .uploadFile(path!, filename, PropertyTitle)
                            //       .then((value) => print("Done"));
                            // },
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Container(
                    child: buildListView(),
                    // child: Row(
                    //   // scrollDirection: Axis.horizontal,
                    //   children: [
                    //     ImagesFromGallery(img_url: 'images/property_img1.jpg'),
                    //     ImagesFromGallery(img_url: 'images/property_img2.jpg'),
                    //     ImagesFromGallery(img_url: 'images/property_img3.jpg'),
                    //     Spacer()
                    //   ],
                    // ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
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
                            propertyDescription = newValue;
                          },
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _controller,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                            squareFit = newValue;
                          });
                        },
                      ),
                      Spacer(),
                      PropertyDetailTile(
                        HintText: "Bed Room",
                        onChange: (newValue) {
                          setState(() {
                            bedRoom = newValue;
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
                            bathRoom = newValue;
                          });
                        },
                      ),
                      Spacer(),
                      PropertyDetailTile(
                        HintText: "Price (USD)",
                        onChange: (newValue) {
                          setState(() {
                            price = newValue;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PreviewProperty.id);
                        },
                        child: Container(
                          height: 70,
                          width: 160,
                          decoration: BoxDecoration(
                            color: kNavigationIconColor,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text('Preview',
                                style: TextStyle(
                                    color: kHighlightedTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Storage _storage = Storage();
                          _storage.uploadPropertyImages();
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
