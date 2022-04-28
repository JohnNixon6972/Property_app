import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_app/screens/profileScreen.dart';
import './screens/addPopertiesScreen2.dart';
import './screens/addPropertiesScreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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

  Future<void> uploadPropertyImages() async {
    var loggedIn_mail = _auth.currentUser!.email;
    for (int i = 0; i < imageFileList!.length; i++) {
      String filePath, fileName;

      filePath = imageFileList![i].path;
      fileName = imageFileList![i].name;
      File file = File(filePath);

      try {
        // await storage.ref('test/$fileName').putFile(file);
        await storage
            .ref('asset/propertyImages/$loggedIn_mail/$PropertyTitle/$fileName')
            .putFile(file);
      } catch (e) {
        print(e);
      } on FirebaseException catch (e) {
        print(e);
      }
    }
  }

  Future<void> uploadPropertyDetails() async {
    print(PropertyAddress);
    print(PropertyTitle);
    print(getCategory());
    print(loggedInUser.email);
    print(getTo());
    print(getType());
    // print(uselastusedaddress);
    var Category = getCategory();
    var to = getTo();
    var type = getType();
    _firestore.collection(loggedInUser.email.toString()).doc(PropertyTitle).set({
      "PropertyTitle": PropertyTitle,
      "PropertyAddress": PropertyAddress,
      "PropertyTo": to,
      "PropertyCategory": Category,
      "PropertyType": type,
      "PropertyDescription": propertyDescription,
      "SquareFit": squareFit,
      "BedRoom": bedRoom,
      "BathRoom": bathRoom,
      "Price": price
    }).then((_) {
      print("Data Added Sucessfully");
    }).catchError((_) {
      print("An error Occured");
    });
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test/').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file $ref');
    });
    return result;
  }
}
