import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/alertPopUp.dart';
import 'package:property_app/screens/homescreen.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'myPropertiesScreen.dart';
import 'editPropertyScreen1.dart';
import 'package:property_app/storage_service.dart';
import '../constants.dart';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../storage_service.dart';
import '../main.dart';

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
late String Elatitude = "";
late String Elongitude = "";
bool dtcpApproved = false;
late String district = "";
Color SelectedToggleBottonColor = kNo;
late myProperty propertyToEdit1;
final _controller = TextEditingController();
final _plotAreaController = TextEditingController();
final _widthController = TextEditingController();
final _lengthController = TextEditingController();
final _centController = TextEditingController();
final _priceController = TextEditingController();
final _constructionAreaController = TextEditingController();
final _bedRoomController = TextEditingController();
final _bathRoomController = TextEditingController();

late int selectedFace;
List<String> directions = ["North", "South", "East", "West"];

List<XFile>? imageFileList = [];
late bool isLand;

void readDetails(myProperty propertyToEdit) {
  propertyToEdit1 = propertyToEdit;
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
  _plotAreaController.text = propertyToEdit.area;
  _priceController.text = propertyToEdit.price;
  _bedRoomController.text = propertyToEdit.bedRoom;
  _bathRoomController.text = propertyToEdit.bathRoom;
  _lengthController.text = propertyToEdit.lenght;
  _widthController.text = propertyToEdit.width;
  _centController.text = propertyToEdit.cent;
  _constructionAreaController.text = propertyToEdit.constructionArea;
  lenght = propertyToEdit.lenght;
  width = propertyToEdit.width;
  cent = propertyToEdit.cent;
}

class _editPropertyScreen2State extends State<editPropertyScreen2> {
  final ImagePicker imagePicker = ImagePicker();
  late List<bool> isSelected;
  _editPropertyScreen2State();
  @override
  void initState() {
    // TODO: implement initState
    PropertyDescription = "";
    plotArea = "";
    constructionArea = "";
    lenght = "";
    width = "";
    cent = "";
    BedRoom = "";
    BathRoom = "";
    Price = "";
    face = "";
    state = "";
    district = "";
    imageFileList = [];
    isSelected = [true, false];
    super.initState();
    readDetails(widget.propertyToEdit);
  }

  void delete_duplicate() {}

  void property() async {
    final _firestore = FirebaseFirestore.instance;
    if (face == "") {
      await popUpAlertDialogBox(context, "Kindly Select Facing");
    } else {
      Storage _storage = Storage();
      setState(
        () {
          isloading = true;
          String propertyAddress = EPropertyAddress;
          String propertyTitle = PropertyTitle;
          String category = getCategory();
          String to = getTo();
          String type = getType();
          String propertyDescription = PropertyDescription;
          String PlotArea = plotArea;
          String bedRoom = BedRoom;
          String bathRoom = BathRoom;
          String price = Price;
          String Face = face;
          print("loading");
          if (propertyTitle != widget.propertyToEdit.propertyName) {
            print("Deleting Duplicate");
            String collection = "Properties" + getTo();
            String title = widget.propertyToEdit.propertyName;
            _firestore.collection(collection).doc(title).delete();
            firebase_storage.FirebaseStorage.instance
                .ref("asset/propertyImages/${userInfo.mobileNumber}/$title")
                .listAll()
                .then((value) {
              value.items.forEach((element) {
                firebase_storage.FirebaseStorage.instance
                    .ref(element.fullPath)
                    .delete();
              });
            });
          }
          myPropertiesAdv.remove(propertyToEdit1.propertyName);
          myProperties.remove(propertyToEdit1);
          _storage.uploadPropertyDetails(
              context,
              dtcpApproved,
              Elatitude,
              Elongitude,
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
              to == widget.propertyToEdit.to &&
                  propertyTitle == widget.propertyToEdit);
          _storage.uploadPropertyImages(
              context, imageFileList, propertyTitle, to, true);
        },
      );
    }
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

  String? get _errorText {
    final _propertyDescription = _controller.value.text;
    if (_propertyDescription.isEmpty) {
      return "Required*";
    }
    return null;
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
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8.0),
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: 270 * pi / 180,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.expand_less_rounded,
                                  size: 36,
                                ),
                              ),
                            ),
                            const Text(
                              'Edit Property',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Container(
                          height: 100,
                          child: buildListView(),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: Text(
                                "DTCP Approved ? ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kHighlightedTextColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          ToggleButtons(
                            constraints: const BoxConstraints(minHeight: 8),
                            fillColor: SelectedToggleBottonColor,
                            // disabledColor: Colors.green,
                            // focusColor: Colors.green,

                            borderWidth: 2,
                            selectedColor: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                if (index == 0) {
                                  SelectedToggleBottonColor = kNo;
                                } else if (index == 1) {
                                  SelectedToggleBottonColor = kYes;
                                }

                                dtcpApproved = index != 0 ? true : false;
                                // print(displayAdminProperties);
                                for (int i = 0; i < isSelected.length; i++) {
                                  isSelected[i] = i == index;
                                }
                              });
                            },
                            isSelected: isSelected,
                          ),
                        ],
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
                                    setState(() {
                                      PropertyDescription = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: _errorText),
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
                                textcontroller: _plotAreaController,
                              ),
                              const Spacer(),
                              !isLand
                                  ? PropertyDetailTile(
                                      HintText: "Building Area(SqFt.)",
                                      onChange: (newValue) {
                                        setState(() {
                                          constructionArea = newValue;
                                          // _bedRoomController.text = newValue;
                                        });
                                      },
                                      currValue: BedRoom,
                                      textcontroller:
                                          _constructionAreaController,
                                    )
                                  : Padding(
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
                                      textcontroller: _lengthController,
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
                            child: SizedBox(
                              height: 65,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: ((_controller
                                                .value.text.isNotEmpty &&
                                            (_plotAreaController.value.text.isNotEmpty &&
                                                _widthController
                                                    .value.text.isNotEmpty &&
                                                _lengthController
                                                    .value.text.isNotEmpty &&
                                                _centController
                                                    .value.text.isNotEmpty &&
                                                _priceController
                                                    .value.text.isNotEmpty)) ||
                                        (_controller.value.text.isNotEmpty &&
                                            (_constructionAreaController
                                                    .value.text.isNotEmpty &&
                                                _bedRoomController
                                                    .value.text.isNotEmpty &&
                                                _bathRoomController
                                                    .value.text.isNotEmpty)))
                                    ? property
                                    : null,
                                child: const Center(
                                  child: Text('save',
                                      style: TextStyle(
                                          color:
                                              kBottomNavigationBackgroundColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  // elevation: 10,
                                  primary: kPrimaryButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                ),
                              ),
                            )
                            // GestureDetector(
                            //   onTap: () {
                            // Storage _storage = Storage();
                            // setState(
                            //   () {
                            //     isloading = true;
                            //     print("loading");
                            //     String propertyAddress = PropertyAddress;
                            //     String propertyTitle = PropertyTitle;
                            //     String category = getCategory();
                            //     String to = getTo();
                            //     String type = getType();
                            //     String propertyDescription =
                            //         PropertyDescription;
                            //     String PlotArea = plotArea;
                            //     String bedRoom = BedRoom;
                            //     String bathRoom = BathRoom;
                            //     String price = Price;
                            //     String Face = face;
                            //     isloading = true;
                            //     print("loading");
                            //     _storage.uploadPropertyDetails(
                            //         context,
                            //         city,
                            //         taluk,
                            //         propertyAddress,
                            //         propertyTitle,
                            //         category,
                            //         to,
                            //         Face,
                            //         type,
                            //         propertyDescription,
                            //         PlotArea,
                            //         cent,
                            //         lenght,
                            //         width,
                            //         _constructionAreaController.text,
                            //         bedRoom,
                            //         bathRoom,
                            //         price,
                            //         state,
                            //         district,
                            //         to == widget.propertyToEdit.to && true);
                            //     _storage.uploadPropertyImages(context,
                            //         imageFileList, propertyTitle, to, true);
                            //   },
                            // );
                            //   },
                            //   child: Container(
                            //     height: 70,
                            //     width: 160,
                            //     decoration: BoxDecoration(
                            //       color: kHighlightedTextColor,
                            //       borderRadius: BorderRadius.circular(35),
                            //     ),
                            //     child: const Center(
                            //       child: Text(
                            //         'Save',
                            //         style: const TextStyle(
                            //             color: kSubCategoryColor,
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
  String? get _errorFieldsText {
    final _fieldsEntered = textcontroller.value.text;
    if (_fieldsEntered.isEmpty) {
      return 'Required*';
    }
    return null;
  }

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
              errorText: _errorFieldsText,
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

        clipBehavior: Clip.none,
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
