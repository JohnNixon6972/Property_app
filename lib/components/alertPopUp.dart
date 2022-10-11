// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

Future<dynamic> popUpAlertDialogBox(BuildContext context, title) {

  return
   showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        
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
