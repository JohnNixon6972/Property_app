import 'dart:async';

import 'package:flutter/material.dart';

import 'package:property_app/constants.dart';

Future<dynamic> popUpAlertDialogBox(BuildContext context, title) {
  Timer _timer;
  IconData icn = Icons.warning;
  return showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        _timer = Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          elevation: 30,
          backgroundColor: kPageBackgroundColor,
          title: Text(
            "⚠️ $title",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryButtonColor,
            ),
          ),
        );
      });
}
