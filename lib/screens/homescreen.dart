import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection

class HomeScreen extends StatelessWidget {
  static const id = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hey Marimar ${Emojis.wavingHandLightSkinTone}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                        Text(
                          "Let's find your your best residence!",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: const Image(
                      image: AssetImage('images/profile_img1.jpg'),
                      height: 70,
                      width: 70,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Center(
                  child: Material(
                    elevation: 2,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: 220,
                      height: 40,
                      child: Row(
                        children: const [
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
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CategoryCard(
                      btn_color: Color.fromARGB(255, 38, 38, 38),
                      text: 'All',
                      width: 60,
                      text_color: Colors.white,
                    ),
                    CategoryCard(
                      btn_color: Color.fromARGB(255, 236, 236, 236),
                      text: 'Appartment',
                      width: 90,
                      text_color: Color.fromARGB(255, 141, 141, 141),
                    ),
                    CategoryCard(
                      btn_color: Color.fromARGB(255, 236, 236, 236),
                      text: 'Townhouse',
                      width: 90,
                      text_color: Color.fromARGB(255, 141, 141, 141),
                    ),
                    CategoryCard(
                      btn_color: Color.fromARGB(255, 236, 236, 236),
                      text: 'Villa',
                      width: 60,
                      text_color: Color.fromARGB(255, 141, 141, 141),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                'Best for you ${Emojis.smilingFaceWithHeartEyes}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 20,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    PropertyCard(imageloc: 'images/property1.jpg'),
                    PropertyCard(imageloc: 'images/property2.jpg'),
                    PropertyCard(imageloc: 'images/property3.jpg'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff5F9FFE),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 188, 188, 188),
                        size: 50,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Color.fromARGB(255, 188, 188, 188),
                        size: 50,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.man_rounded,
                        color: Color.fromARGB(255, 188, 188, 188),
                        size: 50,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String imageloc;
  PropertyCard({required this.imageloc});
  @override
  void initState() {
    print(imageloc);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: const BoxDecoration(
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image(
                      width: 170,
                      fit: BoxFit.cover,
                      image: AssetImage(imageloc),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Nomaden Omah Sekut',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'San Diego, California, USA',
                    style: TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                    ),
                  ),
                ),
                Row(
                  children: const [
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
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CategoryCard(
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
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 45,
        width: width,
        // margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
          color: btn_color,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: text_color, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
