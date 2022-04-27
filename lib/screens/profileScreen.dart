import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/homescreen.dart';
import '../constants.dart';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import '../components/bottomNavigationBar.dart';
import '../components/dialogBoxListWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class profileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

List<String> option_titles = [
  "Personal Information",
  "Email",
  "Phone",
  "Password",
  "Address"
];

final _formKey = GlobalKey<FormState>();

class _profileScreenState extends State<profileScreen> {
  final meaageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  // final CollectionReference collectionRef =
  //     FirebaseFirestore.instance.collection("users");
  final messageTextController = TextEditingController();
  late String name = "";
  late String email = "";
  late String mobileNumber="";
  late String addressLine1="";
  late String addressLine2="";
  late String password="";
  late String city="";
  late String state="";
  late String country="";
  late String postalCode="";

  @override
  void initState() {
    print("Hi");
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        email = loggedInUser.email!;
        var currUserCollection = _firestore.collection("Users");
        var docSanpshot = await currUserCollection.doc(email).get();

        if (docSanpshot.exists) {
          Map<String, dynamic>? data = docSanpshot.data();
          setState(
            () {
              name = data?['name'];
              mobileNumber = data?['number'];
              print(name);
              print(mobileNumber);
            },
          );
        }
        print(email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getDetails() async {
  //   var collection =
  //       FirebaseFirestore.instance.collection('users').doc(loggedInUser.email);
  //   var querySnapshot = await collection.get();
  //   var queryDocumentSnapshot;
  //   // for (var queryDocumentSnapshot in querySnapshot.docs)
  //   if (queryDocumentSnapshot != null) {
  //     Map<String, dynamic> data = await queryDocumentSnapshot.data();
  //     name = await data['name'];
  //     mobileNumber = await data['phone'];
  //   } else {
  //     print("No data found");
  //   }
  // }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image(
                      // width: 800,
                      // height: 500,
                      image: AssetImage('images/backgroundProfileImage3.png'),
                    ),
                  ),
                  Positioned(
                    bottom: -20,

                    left: (width / 2) - 53,

                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      backgroundColor: kPageBackgroundColor,
                      radius: 53,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('images/profile_img1.jpg'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: kHighlightedTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            wordSpacing: -1),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileDetailsContainer(
                      icon: Icons.account_circle_outlined,
                      Title: "Personal Information",
                      SubTitle: name,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.alternate_email_outlined,
                      Title: "Email",
                      SubTitle: email,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.call_outlined,
                      Title: "Phone",
                      SubTitle: mobileNumber,
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.lock_outlined,
                      Title: "Password",
                      SubTitle: "Last updated March 25,2020",
                    ),
                    ProfileDetailsContainer(
                      icon: Icons.add_location_outlined,
                      Title: "Address",
                      SubTitle: "Residential Address",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 2,
              page: profileScreen.id,
            ),
          ],
        ),
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
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          color: kPropertyCardColor,
          borderRadius: BorderRadius.all(
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
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.SubTitle,
                    style: TextStyle(
                        color: kNavigationIconColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (_) => editDetailsPopup(widget.Title,
                            fields[option_titles.indexOf(widget.Title)]));
                  },
                  child: Icon(
                    Icons.expand_less_rounded,
                    color: kNavigationIconColor,
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
    return SimpleDialog(
      backgroundColor: kPageBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        boxTitle,
        style: TextStyle(
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
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
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

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('messages').snapshots(),
//       builder: (context, snapshot) {
//         List messageBubbles = [];
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlue,
//             ),
//           );
//         }
//         final messages = snapshot.data!.docs.reversed;
//         for (var message in messages) {
//           try {
//             final messageText = (message['text']);
//             final messageSender = (message['sender']);
//             final currentUser = loggedInUser.email;
//           } catch (E) {
//             print(E);
//           }
//         }

//         return Expanded(child: Text("hey"));
//       },
//     );
//   }
// }
