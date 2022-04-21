import 'package:flutter/material.dart';
import 'package:property_app/constants.dart';

import '../components/bottomNavigationBar.dart';

class searchScreen extends StatefulWidget {
  static const String id = 'searchScreen';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  Icon customIcon = const Icon(
    Icons.search,
    color: kPrimaryButtonColor,
  );
  Widget customSearchBar = const Text(
    'Search',
    style: TextStyle(color: kPrimaryButtonColor),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: kBottomNavigationBackgroundColor,
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  // Perform set of instructions.
                  customIcon = const Icon(
                    Icons.cancel,
                    color: kPrimaryButtonColor,
                  );
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: kPrimaryButtonColor,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your text here',
                        hintStyle: TextStyle(
                          color: kPrimaryButtonColor,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: kPrimaryButtonColor,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text(
                    'Search',
                    style: TextStyle(
                      color: kPrimaryButtonColor,
                    ),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  child: Image(
                    image: AssetImage("images/try10.png"),
                  ),
                ),
              ),
            ),
            BottomPageNavigationBar(
              flex_by: 1,
              page: searchScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}
