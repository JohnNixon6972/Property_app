import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/approvedPropertiesScreen.dart';
import 'package:property_app/screens/homescreen.dart';
import 'package:property_app/screens/myPropertiesScreen.dart';
import 'package:property_app/screens/unApprovedPropertiesScreen.dart';
// import 'package:property_app/screens/loginScreen.dart';
import '../constants.dart';
import 'dart:math';
import '../components/dialogBoxListWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../screens/registerScreen.dart';
import '../screens/loginScreen.dart';
import '../components/scaffoldBottomAppBar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

List<String> option_titles = [
  "Personal Information",
  "Email",
  // "Phone",
  "Password",
  "Address",
];

final _firestore = FirebaseFirestore.instance;

class _profileScreenState extends State<profileScreen> {
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      XFile imageFile = XFile(pickedFile.path);
    }
  }

  final meaageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    // print("Hi");
    getCurrentUser();
    super.initState();
  }

  void updateVisibility(bool isHidden) {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void getCurrentUser() async {
    try {
      var currUserCollection = _firestore.collection("Users");
      var docSanpshot =
          await currUserCollection.doc(_auth.currentUser!.email).get();

      if (docSanpshot.exists) {
        Map<String, dynamic>? data = docSanpshot.data();
        setState(
          () {
            userInfo.name = data?['name'];
            userInfo.mobileNumber = data?['number'];
            userInfo.profileImgUrl = data?['profileImgUrl'];
            print(userInfo.name);
            print(userInfo.mobileNumber);
          },
        );
      }
      print(userInfo.email);
    } catch (e) {
      print(e);
    }
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      final _auth = FirebaseAuth.instance;
      final _firestore = FirebaseFirestore.instance;
      late firebase_storage.Reference ref;
      late CollectionReference imgRef;
      String filePath, fileName;

      filePath = image.path;
      fileName = image.name;
      File file = File(filePath);

      try {
        // await storage.ref('test/$fileName').putFile(file);
        ref = storage
            .ref()
            .child('asset/profileImages/${userInfo.email}/$fileName');
        await ref.putFile(file).whenComplete(() async {
          await ref.getDownloadURL().then((value) async {
            // imgRef.add({'url': value});
            await _firestore
                .collection('Users')
                .doc(userInfo.email)
                .update({"profileImgUrl": value});
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Widget build(BuildContext context) {
    physics:
    const BouncingScrollPhysics();
    double width = MediaQuery.of(context).size.width;

    print(width);
    double backgroundImageHeight = 215;

    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 11,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: const Radius.circular(30),
                    ),
                    child: Opacity(
                      opacity: 0.80,
                      child: Image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: backgroundImageHeight,
                        image: const AssetImage(
                            'images/profileBackgroundImage11.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: backgroundImageHeight - 53,
                    left: (width / 2) - 53,
                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundColor: kPageBackgroundColor,
                      radius: 53,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: userInfo.profileImgUrl == ""
                            ? const Image(
                                height: 100,
                                width: 100,
                                image:
                                    const AssetImage('images/profile_img9.png'))
                            : CachedNetworkImage(
                                cacheManager: customCacheManager,
                                key: UniqueKey(),
                                imageUrl: userInfo.profileImgUrl,
                                height: 100,
                                width: 100,
                                // maxHeightDiskCache: 230,
                                // maxWidthDiskCache: 190,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: kHighlightedTextColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.black12,
                                  child: const Icon(
                                    Icons.error,
                                    color: kHighlightedTextColor,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: backgroundImageHeight + 20,
                      left: (width / 2) + 35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: const Icon(
                          Icons.flip_camera_ios,
                          color: kHighlightedTextColor,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: backgroundImageHeight + 53 + 5, bottom: 1),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            userInfo.name,
                            style: const TextStyle(
                                color: kHighlightedTextColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                wordSpacing: -1),
                          ),
                          Text(
                            userInfo.mobileNumber,
                            style: const TextStyle(
                                color: kSubCategoryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await FirebaseAuth.instance.signOut();
                              await prefs.clear();
                              myPropertiesAdv = [];
                              bookmarkedPropertyNames = [];
                              Navigator.pushNamed(context, loginScreen.id);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: kPrimaryButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Log Out',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 10,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ProfileDetailsContainer(
                                    icon: Icons.account_circle_outlined,
                                    Title: "Personal Information",
                                    SubTitle: userInfo.name,
                                  ),
                                  // ProfileDetailsContainer(
                                  //   icon: Icons.call_outlined,
                                  //   Title: "Phone",
                                  //   SubTitle: userInfo.mobileNumber,
                                  // ),
                                  ProfileDetailsContainer(
                                    icon: Icons.call_outlined,
                                    Title: "Email",
                                    SubTitle: userInfo.email,
                                  ),
                                  ProfileDetailsContainer(
                                    icon: Icons.lock_outlined,
                                    Title: "Password",
                                    SubTitle: "",
                                    // SubTitle: userInfo.password,
                                  ),
                                  userInfo.name == "john"
                                      ? ProfileDetailsContainer(
                                          icon: Icons.approval_outlined,
                                          Title: "Un-Approved Properties",
                                          SubTitle: "",
                                        )
                                      : Center(),

                                  userInfo.name != "john"
                                      ? ProfileDetailsContainer(
                                          icon: Icons.add_location_outlined,
                                          Title: "Address",
                                          SubTitle: "Residential Address",
                                        )
                                      : ProfileDetailsContainer(
                                          icon: Icons.home_work_sharp,
                                          Title: "Approved Properties",
                                          SubTitle: ""),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ProfileDetailsContainer(
                                    icon: Icons.house,
                                    Title: "My Properties",
                                    SubTitle: "",
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
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
            // BottomPageNavigationBar(
            //   flex_by: 2,
            //   page: profileScreen.id,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: const scaffoldBottomAppBar(
        flex_by: 2,
        page: profileScreen.id,
      ),
    );
  }
}

class ProfileDetailsContainer extends StatefulWidget {
  final IconData icon;
  final String Title;
  final String SubTitle;

  ProfileDetailsContainer(
      {required this.icon, required this.Title, required this.SubTitle});

  @override
  State<ProfileDetailsContainer> createState() =>
      _ProfileDetailsContainerState();
}

class _ProfileDetailsContainerState extends State<ProfileDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          color: kPropertyCardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 70,
        // color: kSecondaryButtonColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: kPageBackgroundColor,
                child: Icon(
                  widget.icon,
                  size: 32,
                  color: kNavigationIconColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.Title,
                      style: const TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.SubTitle,
                    style: const TextStyle(
                        color: kBottomNavigationBackgroundColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    if (widget.Title == "Approved Properties") {
                      Navigator.pushNamed(context, ApprovedPropertiesScreen.id);
                    } else if (widget.Title == "Un-Approved Properties") {
                      Navigator.pushNamed(
                          context, UnApprovedPropertiesScreen.id);
                    } else if (widget.Title == "My Properties") {
                      Navigator.pushNamed(context, myPropertiesScreen.id);
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => editDetailsPopup(widget.Title,
                              fields[option_titles.indexOf(widget.Title)]));
                    }

                    setState(() {
                      // Navigator.pop(context);
                    });
                  },
                  child: const Icon(
                    Icons.expand_less_rounded,
                    color: kHighlightedTextColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SimpleDialog editDetailsPopup(String boxTitle, List<Widget> childern) {
    final _auth = FirebaseAuth.instance;
    return SimpleDialog(
      backgroundColor: kPageBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        boxTitle,
        style: const TextStyle(
          color: kHighlightedTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Column(children: childern),
                ElevatedButton(
                  onPressed: () async {
                    _firestore
                        .collection("Users")
                        .doc(_auth.currentUser!.email)
                        .update({
                      "email": userInfo.email,
                      "name": userInfo.name,
                      "number": userInfo.mobileNumber,
                      "addressLine1": userInfo.addressLine1,
                      "addressLine2": userInfo.addressLine2,
                      "city": userInfo.city,
                      "state": userInfo.state,
                      "country": userInfo.country,
                      "postalcode": userInfo.postalCode,
                    });
                    Navigator.pop(context);
                    setState(() {
                      try {
                        if (passwordKey.currentState!.validate()) {}
                        print(userInfo.password);
                        userInfo.name = userInfo.name;
                        if (newPassword == confirmNewPassword) {
                          var loggedInUser = _auth.currentUser;
                          loggedInUser
                              ?.updatePassword(userInfo.password)
                              .then((_) {
                            userInfo.password = newPassword;
                            print(userInfo.password);
                            print("Successfully changed password");
                          }).catchError((error) {
                            print(
                                "Password can't be changed" + error.toString());
                          });
                        } else {
                          print("Reconfirm New Password");
                        }
                        print("Process data");
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
