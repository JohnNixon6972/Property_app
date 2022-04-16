import 'package:flutter/material.dart';
import 'dart:math';

class PropertyDetailsScreen extends StatelessWidget {
  static const id = 'propertyDetailsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: 270 * pi / 180,
                    child: Icon(
                      Icons.expand_less_rounded,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Center(
                    child: Text(
                      'Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 18, bottom: 18),
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    // height: 400,
                    width: double.infinity,
                    image: AssetImage('images/propertyDetailed1.jpg'),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nomaden Omah Sekut',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'San Diego, California, USA',
                        style: TextStyle(
                            color: Color.fromARGB(255, 141, 141, 141),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 55,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$128 ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff5F9FFE),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " / Month",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 141, 141, 141),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 213, 213, 213),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 213, 213),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 141, 141, 141),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 213, 213),
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.bathtub_outlined,
                              color: Color.fromARGB(255, 141, 141, 141),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bathroom',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141),
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 213, 213),
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.bed_rounded,
                              color: Color.fromARGB(255, 141, 141, 141),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bedroom',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141),
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 213, 213),
                        borderRadius: BorderRadius.all((Radius.circular(15)))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.crop_square_rounded,
                            color: Color.fromARGB(255, 141, 141, 141),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Bathroom',
                            style: TextStyle(
                                color: Color.fromARGB(255, 141, 141, 141),
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '465 FT.',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/profile_img2.jpg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Laura Kimono',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Owner',
                        style: TextStyle(
                          color: Color.fromARGB(255, 141, 141, 141),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color.fromARGB(255, 213, 230, 255),
                          child: Icon(
                            Icons.mail,
                            color: Color(0xff5F9FFE),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color.fromARGB(255, 213, 230, 255),
                          child: Icon(
                            Icons.call,
                            color: Color(0xff5F9FFE),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              lis(
                child: Container(
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      // height: 400,
                      width: double.infinity,
                      height: 250,
                      image: AssetImage('images/propertyDetailed1.jpg'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
