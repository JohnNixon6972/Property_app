import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import './screens/homescreen.dart';
import './screens/addPopertiesScreen2.dart';
import './screens/addPropertiesScreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'currentUserInformation.dart';
import 'main.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late firebase_storage.Reference ref;
  late CollectionReference imgRef;

  // Future<void> uploadFile(
  //     String filePath, String fileName, String propertyName) async {
  //   File file = File(filePath);
  //   var loggedIn_mail = _auth.currentUser!.email;

  //   try {
  //     // await storage.ref('test/$fileName').putFile(file);
  //     await storage
  //         .ref('asset/propertyImages/$loggedIn_mail/$propertyName')
  //         .putFile(file);
  //   } catch (e) {
  //     print(e);
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> uploadPropertyImages(BuildContext context) async {
    var loggedIn_mail =await _auth.currentUser!.email;
    for (int i = 0; i < imageFileList!.length; i++) {
      String filePath, fileName;

      filePath = imageFileList![i].path;
      fileName = imageFileList![i].name;
      File file = File(filePath);
      print("Adding property images");

      try {
        // await storage.ref('test/$fileName').putFile(file);
        ref = storage.ref().child(
            'asset/propertyImages/$loggedIn_mail/$PropertyTitle/$fileName');
        await ref.putFile(file).whenComplete(() async {
          await ref.getDownloadURL().then((value) async{
            // imgRef.add({'url': value});
          await  _firestore
                .collection('Properties' + getTo())
                .doc(PropertyTitle)
                .update({"imgUrl${i + 1}": value});
          });
        });
      } catch (e) {
        print(e);
      }
    
    }
    await  _firestore
                .collection('Properties' + getTo())
                .doc(PropertyTitle)
                .update({"isSetImages": "True"});
    print("Added Property Images");
  }

  Future<void> uploadPropertyDetails(BuildContext context) async {
    print(PropertyAddress);
    print(PropertyTitle);
    print(getCategory());
    print(userInfo.email);
    print(getTo());
    print(getType());
    // print(uselastusedaddress);
    var Category = getCategory();
    var to = getTo();
    var type = getType();
    _firestore.collection('Properties' + to).doc(PropertyTitle).set({
      "PropertyBy": userInfo.email,
      "OwnerName": userInfo.name,
      "PropertyTitle": PropertyTitle,
      "PropertyAddress": PropertyAddress,
      "PropertyTo": to,
      "PropertyCategory": Category,
      "PropertyType": type,
      "PropertyDescription": propertyDescription,
      "SquareFit": squareFit,
      "BedRoom": bedRoom,
      "BathRoom": bathRoom,
      "isSetImages":"False",
      "Price": price,
      "imgUrl1": "",
      "imgUrl2": "",
      "imgUrl3": "",
      "imgUrl4": "",
      "imgUrl5": "",
      "imgUrl6": "",
      "imgUrl7": "",
      "imgUrl8": "",
      "imgUrl9": "",
      "imgUrl10": "",
    }).then((_) {
      print("Data Added Sucessfully");
      Navigator.pushNamed(context, HomeScreen.id);
    }).catchError((_) {
      print("An error Occured");
    });
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test/').listAll();

    for (var ref in result.items) {
      print('Found file $ref');
    }
    return result;
  }
}
