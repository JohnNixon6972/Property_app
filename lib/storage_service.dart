// ignore_for_file: non_constant_identifier_names

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';


class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final _firestore = FirebaseFirestore.instance;
  late firebase_storage.Reference ref;
  late CollectionReference imgRef;

  Future<void> uploadPropertyImages(
      BuildContext context,
      List<XFile>? imageFileList,
      
      String PropertyTitle,
      String to,
      bool isUpdate) async {
    for (int i = 0; i < imageFileList!.length; i++) {
      String filePath, fileName;

      filePath = imageFileList[i].path;
      fileName = imageFileList[i].name;
      File file = File(filePath);
      // print("Adding property images");

      try {
        // await storage.ref('test/$fileName').putFile(file);
        ref = storage.ref().child(
            'asset/propertyImages/${userInfo.mobileNumber}/$PropertyTitle/$fileName');
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
        // print(e);
      }
    }
    await _firestore
        .collection('Properties' + to)
        .doc(PropertyTitle)
        .update({"isSetImages": "True"});
    // print("Added Property Images");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (route) => false);
  }

  Future<void> uploadPropertyDetails(
      BuildContext context,
      bool dtcpApproved,
      String latitude,
      String longitude,
      String city,
      String taluk,
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
      String state,
      String district,
      bool isUpdate) async {
    // print(propertyAddress);
    // print(propertyTitle);
    // print(type);
    // print(to);
    // print(userInfo.email);

    // print(uselastusedaddress);

    if (!isUpdate) {
      // print("Hi");
      String propertyFor = to == "Rent" ? "Sell" : "Rent";
      String collection = "Properties" + propertyFor;
      // print(collection);
      // print(propertyTitle);
      // print("Deleting Duplicate");
      await _firestore.collection(collection).doc(propertyTitle).delete();
      await firebase_storage.FirebaseStorage.instance
          .ref("asset/propertyImages/${userInfo.mobileNumber}/$propertyTitle")
          .listAll()
          .then((value) {
        for (var element in value.items) {
          firebase_storage.FirebaseStorage.instance
              .ref(element.fullPath)
              .delete();
        }
      });
    }
    !isUpdate
        ? _firestore.collection('Properties' + to).doc(propertyTitle).set({
            "DTCPApproved": "$dtcpApproved",
            "City": city,
            "Taluk": taluk,
            "PropertyBy": userInfo.email,
            "OwnerName": userInfo.name,
            "PropertyTitle": propertyTitle,
            "PropertyAddress": propertyAddress,
            "LandLength": Lenght,
            "LandWidth": Width,
            "Cent": Cent,
            "PropertyTo": to,
            "PropertyCategory": category,
            "PropertyDirection": face,
            "PropertyType": type,
            "PropertyDescription": propertyDescription,
            "PlotArea": plotArea,
            "ConstructionArea": constructionArea,
            "BedRoom": bedRoom,
            "BathRoom": bathRoom,
            "isSetImages": "False",
            "Price": price,
            "PhNo": userInfo.mobileNumber,
            "profileImgUrl": userInfo.profileImgUrl,
            "State": 'Tamil Nadu',
            "District": district,
            "latitude":latitude,
            "longitude":longitude,
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
            "isApproved": "False"
          }).then((_) {
            // print("Data Added Sucessfully");
          }).catchError((_) {
            // print("An error Occured");
          })
        : _firestore.collection('Properties' + to).doc(propertyTitle).update({
            "DTCPApproved": "$dtcpApproved",
            "PropertyBy": userInfo.email,
            "OwnerName": userInfo.name,
            "PropertyTitle": propertyTitle,
            "PropertyAddress": propertyAddress,
            "LandLength": Lenght,
            "LandWidth": Width,
            "City": city,
            "Taluk": taluk,
            "Cent": Cent,
            "latitude":latitude,
            "longitude":longitude,
            "PropertyTo": to,
            "PropertyCategory": category,
            "PropertyType": type,
            "PropertyDescription": propertyDescription,
            "PlotArea": plotArea,
            "ConstructionArea": constructionArea,
            "BedRoom": bedRoom,
            "BathRoom": bathRoom,
            "isSetImages": "False",
            "Price": price,
            "PhNo": userInfo.mobileNumber,
            "profileImgUrl": userInfo.profileImgUrl,
            "State": 'Tamil Nadu',
            "District": district,
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
            "isApproved": "False"
          }).then((_) {
            // print("Data Added Sucessfully");
          }).catchError((_) {
            // print("An error Occured");
          });
  }

  bool addRequest(
      String district,
      String taluk,
      String category,
      String to,
      String type,
      String price,
      String city,
      String description,
      String length,
      String width) {
    _firestore.collection("RequestedProperties").add({
      // "PropertyBy": userInfo.email,
      "description": description,
      "OwnerName": userInfo.name,
      "City": city,
      "Taluk": taluk,
      "PropertyTo": to,
      "PropertyCategory": category,
      "PropertyType": type,
      "isSetImages": "False",
      "Price": price,
      "PhNo": userInfo.mobileNumber,
      "profileImgUrl": userInfo.profileImgUrl,
      "State": 'Tamil Nadu',
      "District": district,
      "PropertyBy": userInfo.email,
      "Length": length,
      "Width": width,
    }).then((_) {
      // print("Data Added Sucessfully");
      return true;
    }).catchError((e) {
      // print(e);
      return false;
    });
    return true;
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test/').listAll();

    // for (var ref in result.items) {
    //   print('Found file $ref');
    // }
    return result;
  }
}
