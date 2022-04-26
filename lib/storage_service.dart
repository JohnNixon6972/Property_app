import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('text/$fileName').putFile(file);
    } catch (e) {
      print(e);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // Future<firebase_storage.ListResult> listFiles() async {
  //   firebase_storage.ListResult result = await storage.ref('test/').listAll();

  //   result.items.forEach((firebase_storage.Reference ref) {
  //     print('Found file $ref');
  //   });
  //   return result;
  // }
}
