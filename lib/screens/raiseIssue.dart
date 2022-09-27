// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print, file_names, constant_identifier_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/checkRequested.dart';
import '../components/requestProperty.dart';
import '../constants.dart';


bool idx = true;

class raiseAnIssue extends StatefulWidget {
  static const id = 'raiseAnIssue';
  @override
  State<raiseAnIssue> createState() => _raiseAnIssueState();
}

class _raiseAnIssueState extends State<raiseAnIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPageBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                      minHeight: MediaQuery.of(context).size.height * 0.07,
                      minWidth: double.infinity,
                      initialLabelIndex: idx ? 0 : 1,
                      totalSwitches: 2,
                      cornerRadius: 50,
                      // isVertical: true,
                      activeBgColor: const [kBottomNavigationBackgroundColor],
                      inactiveBgColor: kNavigationIconColor,
                      activeBorders: [
                        Border.all(color: kHighlightedTextColor, width: 2),
                      ],
                      activeFgColor: kHighlightedTextColor,
                      inactiveFgColor: kHighlightedTextColor,
                      fontSize: 16,
                      iconSize: 20,
                      animate: true,
                      animationDuration: 1000,
                      curve: Curves.ease,

                      radiusStyle: true,
                      labels: const ["Request Property", "Check Requests"],
                      icons: const [
                        Icons.back_hand,
                        Icons.comment_bank_rounded
                      ],
                      onToggle: ((index) {
                        print(index);
                        setState(() {
                          idx = !idx;
                        });
                      }),
                    ),
                  ),
                  idx ? requestProperty() : checkRequested()
                ],
              )),
        ));
  }
}





