import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import './screens/homescreen.dart';
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

  Future<void> uploadPropertyImages(
      BuildContext context,
      List<XFile>? imageFileList,
      String PropertyTitle,
      String to,
      bool isUpdate) async {
    var loggedIn_mail = await _auth.currentUser!.email;
    for (int i = 0; i < imageFileList!.length; i++) {
      String filePath, fileName;

      filePath = imageFileList[i].path;
      fileName = imageFileList[i].name;
      File file = File(filePath);
      print("Adding property images");

      try {
        // await storage.ref('test/$fileName').putFile(file);
        ref = storage.ref().child(
            'asset/propertyImages/$loggedIn_mail/$PropertyTitle/$fileName');
        await ref.putFile(file).whenComplete(() async {
          await ref.getDownloadURL().then((value) async {
            // imgRef.add({'url': value});
            await _firestore
                .collection('Properties' + to)
                .doc(PropertyTitle)
                .update({"imgUrl${i + 1}": value});
          });
        });
      } catch (e) {
        print(e);
      }
    }
    await _firestore
        .collection('Properties' + to)
        .doc(PropertyTitle)
        .update({"isSetImages": "True"});
    print("Added Property Images");
    isUpdate
        ? Navigator.pop(context)
        : Navigator.pushNamed(context, HomeScreen.id);
  }

  Future<void> uploadPropertyDetails(
      BuildContext context,
      String propertyAddress,
      String propertyTitle,
      String category,
      String to,
      String face,
      String type,
      String propertyDescription,
      String plotArea,
      String Cent,
      String Lenght,
      String Width,
      String constructionArea,
      String bedRoom,
      String bathRoom,
      String price,
      bool isUpdate) async {
    print(propertyAddress);
    print(propertyTitle);
    print(type);
    print(to);
    print(userInfo.email);

    // print(uselastusedaddress);
    if (!isUpdate) {
      // print("Hi");
      String propertyFor = to == "Rent" ? "Sell" : "Rent";
      String collection = "Properties" + propertyFor;
      // print(collection);
      // print(propertyTitle);
      print("Deleting Duplicate");
      await _firestore.collection(collection).doc(propertyTitle).delete();
      await firebase_storage.FirebaseStorage.instance
          .ref("asset/propertyImages/${userInfo.email}/$propertyTitle")
          .listAll()
          .then((value) {
        value.items.forEach((element) {
          firebase_storage.FirebaseStorage.instance
              .ref(element.fullPath)
              .delete();
        });
      });
    }
    !isUpdate
        ? _firestore.collection('Properties' + to).doc(propertyTitle).set({
            "PropertyBy": userInfo.email,
            "OwnerName": userInfo.name,
            "PropertyTitle": propertyTitle,
            "PropertyAddress": propertyAddress,
            "LandLength":Lenght,
            "LandWidth":Width,
            "Cent":Cent,
            "PropertyTo": to,
            "PropertyCategory": category,
            "PropertyDirection":face,
            "PropertyType": type,
            "PropertyDescription": propertyDescription,
            "PlotArea":plotArea,
            "ConstructionArea":constructionArea,
            "BedRoom": bedRoom,
            "BathRoom": bathRoom,
            "isSetImages": "False",
            "Price": price,
            "PhNo":userInfo.mobileNumber,
            "PlotFace"
            "profileImgUrl":"",
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
            "isApproved":"False"
          }).then((_) {
            print("Data Added Sucessfully");
          }).catchError((_) {
            print("An error Occured");
          })
        : _firestore.collection('Properties' + to).doc(propertyTitle).update({
            "PropertyBy": userInfo.email,
            "OwnerName": userInfo.name,
            "PropertyTitle": propertyTitle,
            "PropertyAddress": propertyAddress,
            "LandLength":Lenght,
            "LandWidth":Width,
            "Cent":Cent,
            "PropertyTo": to,
            "PropertyCategory": category,
            "PropertyType": type,
            "PropertyDescription": propertyDescription,
            "PlotArea":plotArea,
            "ConstructionArea":constructionArea,
            "BedRoom": bedRoom,
            "BathRoom": bathRoom,
            "isSetImages": "False",
            "Price": price,
            "PhNo":userInfo.mobileNumber,
            "PlotFace"
            "profileImgUrl":"",
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
            "isApproved":"False"
          }).then((_) {
            print("Data Added Sucessfully");
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
