import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection

class HomeScreen extends StatelessWidget {
  static const id = 'homeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Marimar ${Emojis.wavingHandLightSkinTone}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 151, 151, 151),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Let's find your your best residence!",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: AssetImage('images/profile_img1.jpg'),
                      height: 70,
                      width: 70,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: 220,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        "  Add Property ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 164, 164, 164)),
                      ),
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Color.fromARGB(255, 38, 38, 38),
                        child: Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 228, 228, 228),
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryCard(
                    btn_color: Color.fromARGB(255, 38, 38, 38),
                    text: 'All',
                    width: 60,
                    text_color: Colors.white,
                  ),
                  categoryCard(
                    btn_color: Color.fromARGB(255, 236, 236, 236),
                    text: 'Appartment',
                    width: 90,
                    text_color: Color.fromARGB(255, 141, 141, 141),
                  ),
                  categoryCard(
                    btn_color: Color.fromARGB(255, 236, 236, 236),
                    text: 'Townhouse',
                    width: 90,
                    text_color: Color.fromARGB(255, 141, 141, 141),
                  ),
                  categoryCard(
                    btn_color: Color.fromARGB(255, 236, 236, 236),
                    text: 'Villa',
                    width: 60,
                    text_color: Color.fromARGB(255, 141, 141, 141),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Best for you ${Emojis.smilingFaceWithHeartEyes}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PropertyCard(),
                    PropertyCard(),
                    PropertyCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  height: 270,
                  width: 200,
                  image: AssetImage('images/property1.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Nomaden Omah Sekut',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'San Diego, California, USA',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 141, 141),
                ),
              ),
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}

class categoryCard extends StatelessWidget {
  categoryCard(
      {required this.text_color,
      required this.btn_color,
      required this.text,
      required this.width});
  final Color btn_color;
  final Color text_color;
  final String text;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 45,
        width: width,
        // margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 173, 173, 173)),
          color: btn_color,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: text_color, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
