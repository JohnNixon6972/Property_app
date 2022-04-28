import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final _auth = FirebaseAuth.instance; 

  Future<void> uploadFile(String filePath, String fileName,String propertyName) async {
    File file = File(filePath);
    var loggedIn_mail = _auth.currentUser!.email; 

    try {
      // await storage.ref('test/$fileName').putFile(file);
      await storage.ref('asset/propertyImages/$loggedIn_mail/$propertyName').putFile(file);
    } catch (e) {
      print(e);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test/').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file $ref');
    });
    return result;
  }
}
