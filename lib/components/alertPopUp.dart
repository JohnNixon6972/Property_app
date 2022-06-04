import 'dart:async';
import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

Future<dynamic> popUpAlertDialogBox(BuildContext context, title) {
  Timer _timer;
  IconData icn = Icons.warning;
  return
   showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        // _timer = Timer(const Duration(seconds: 5), () {
        //   if(builderContext != null){

        //     Navigator.of(builderContext).pop();
        //   }
        //   // Navigator.pop(context);
        // });
        return AlertDialog(
          elevation: 30,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            side: BorderSide(
              color: kPageBackgroundColor,
              width: 4,
            ),
          ),
          backgroundColor: kBottomNavigationBackgroundColor,
          title: Text(
            "$title",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kPrimaryButtonColor,
            ),
          ),
        );
      });
}
