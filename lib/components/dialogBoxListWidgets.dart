// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:property_app/main.dart';

final dialogKey = GlobalKey<FormState>();
final passwordKey = GlobalKey<FormState>();
late String currentPassowrd;
late String newPassword = userInfo.password;
late String confirmNewPassword = userInfo.password;
// bool _isHidden = true;
// final _firestore = FirebaseFirestore.instance;

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);
  

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
