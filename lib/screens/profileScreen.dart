// ignore_for_file: non_constant_identifier_names, camel_case_types, use_key_in_widget_constructors

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/components/alertPopUp.dart';
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
    // getCurrentUser();
    super.initState();
  }

  void updateVisibility(bool isHidden) {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void getCurrentUser() async {
    try {
      // var currUserCollection = _firestore.collection("Users");
      // var docSanpshot =
      //     // await currUserCollection.doc(_auth.currentUser!.email).get();
      //     await currUserCollection.doc(userInfo.mobileNumber).get();

      // if (docSanpshot.exists) {
      //   Map<String, dynamic>? data = docSanpshot.data();
      //   setState(
      //     () {
      //       userInfo.name = data?['name'];
      //       userInfo.mobileNumber = data?['number'];
      //       userInfo.profileImgUrl = data?['profileImgUrl'];
      //       print(userInfo.name);
      //       print(userInfo.mobileNumber);
      //     },
      //   );
      // }
      print(userInfo.mobileNumber);
      Object? data;
      _firestore
          .collection('Users')
          .doc(userInfo.mobileNumber)
          .get()
          .then((value) => {
                // print(value.data()!["password"]),
                print(value.data()!["name"]),
                userInfo.name = value.data()!["name"],
                userInfo.password = value.data()!["password"],
              });
      // print(userInfo.name);
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
            .child('asset/profileImages/${userInfo.mobileNumber}/$fileName');
        await ref.putFile(file).whenComplete(() async {
          await ref.getDownloadURL().then((value) async {
            // imgRef.add({'url': value});
            await _firestore
                .collection('Users')
                .doc(userInfo.mobileNumber)
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
                clipBehavior: Clip.none, children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
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
  final dialogKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  late String currentPassowrd;
  late String newPassword = userInfo.password;
  late String confirmNewPassword = userInfo.password;
  // void updateValue(String value)
  Widget build(BuildContext context) {
    List<List<Widget>> fields = [
      [
        Form(
          key: dialogKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.name = newValue;
                  setState(() {
                    userInfo.name = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.name = value;
                  }
                  return null;
                  // return firstName;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.name,
                  prefixIcon:
                      const Icon(Icons.badge, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
      [
        Form(
          key: dialogKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.email = newValue;
                  setState(() {
                    userInfo.email = newValue;
                  });

                  // print(userInfo.email);
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.email = value;
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.email,
                  prefixIcon:
                      const Icon(Icons.mail, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
      [
        Form(
          key: passwordKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // controller: _currentPassowrd,
                // obscureText: true,
                onChanged: (value) {
                  currentPassowrd = value;
                  setState(() {
                    currentPassowrd = value;
                  });
                  // userInfo.password = value;
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else if (userInfo.password != currentPassowrd) {
                    print("Invalid Password");
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Current Password.',
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // obscureText: true,
                onChanged: (value) {
                  newPassword = value;
                  setState(() {
                    newPassword = value;
                  });
                  // print("New Password Entered");
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'New password.',
                  prefixIcon:
                      const Icon(Icons.lock, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  confirmNewPassword = value;
                  setState(() {
                    confirmNewPassword = value;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    confirmNewPassword = value;
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Confirm new password.',
                  prefixIcon:
                      const Icon(Icons.lock_open, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
      [
        Form(
          key: dialogKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.addressLine1 = newValue;
                  setState(() {
                    userInfo.addressLine1 = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.addressLine1 = value;
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.addressLine1,
                  prefixIcon:
                      const Icon(Icons.home, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.addressLine2 = newValue;
                  setState(() {
                    userInfo.addressLine2 = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.addressLine2 = value;
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.addressLine2,
                  prefixIcon:
                      const Icon(Icons.house, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.city = newValue;
                  setState(() {
                    userInfo.city = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.city = value;
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.city,
                  prefixIcon: const Icon(Icons.location_city,
                      color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.state = newValue;
                  setState(() {
                    userInfo.state = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.state = value;
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.state,
                  prefixIcon:
                      const Icon(Icons.cabin, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.country = newValue;
                  setState(() {
                    userInfo.country = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.country = value;
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.country,
                  prefixIcon:
                      const Icon(Icons.countertops, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newValue) {
                  userInfo.postalCode = newValue;
                  setState(() {
                    userInfo.postalCode = newValue;
                  });
                },
                cursorColor: kPrimaryButtonColor,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                style: const TextStyle(color: kPrimaryButtonColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  } else {
                    userInfo.postalCode = value;
                  }

                  // return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: userInfo.postalCode,
                  prefixIcon:
                      const Icon(Icons.code, color: kPrimaryButtonColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    ];

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
                  color: kBottomNavigationBackgroundColor,
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
                        fontSize: 13.5,
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
                          builder: (_) => editDetailsPopup(
                              widget.Title,
                              fields[option_titles.indexOf(widget.Title)],
                              context));
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

  SimpleDialog editDetailsPopup(
      String boxTitle, List<Widget> childern, BuildContext context) {
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
                        .doc(userInfo.mobileNumber)
                        .update({
                      "email": userInfo.email,
                      "name": userInfo.name,
                      // "number": userInfo.mobileNumber,
                      "addressLine1": userInfo.addressLine1,
                      "addressLine2": userInfo.addressLine2,
                      "city": userInfo.city,
                      "country": userInfo.country,
                      "state": userInfo.state,
                      "postalcode": userInfo.postalCode,
                    });

                    try {
                      if (passwordKey.currentState!.validate()) {
                        // print(userInfo.password);
                        // userInfo.name = userInfo.name;
                        // print("Current Password : " + currentPassowrd);
                        // print("User Password : " + userInfo.password);
                        // print("New Password : " + newPassword);
                        // print("Confirmed New Password : " + confirmNewPassword);
                        if (userInfo.password == currentPassowrd) {
                          if (newPassword == confirmNewPassword) {
                            _firestore
                                .collection('Users')
                                .doc(userInfo.mobileNumber)
                                .update({"password": newPassword});

                           await popUpAlertDialogBox(
                                context, "Successfully changed Password");
                          } else if (newPassword != confirmNewPassword) {
                          await  popUpAlertDialogBox(
                                context, "Passwords don't match");
                          }
                        } else {
                        await  popUpAlertDialogBox(context, "Invalid Password");
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
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
