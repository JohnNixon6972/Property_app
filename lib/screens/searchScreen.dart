import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:property_app/components/scaffoldBottomAppBar.dart';
import 'package:property_app/constants.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:property_app/screens/propertyDetailsScreen.dart';

import './homescreen.dart';

final myController = TextEditingController();

class searchScreen extends StatefulWidget {
  static const String id = 'searchScreen';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late List<bool> isSelected;
  String query = "";
  String searchType = "PropertiesRent";
  late String state = "";
  late String district = "";
  List<String> districts = [];
  int selectedDistrict = 0;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
    myController.addListener(() {
      // print("myController.text = ${myController.text}");
    });
  }

  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection(searchType).snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: kHighlightedTextColor,
              ),
            );
          } else if (query == "" && state == "" && district == "") {
            return Container();
          } else {
            if (query != "" &&
                snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['PropertyAddress']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 430),
                child: Center(
                  child: Text(
                    "No Such Place For Property Found!",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: kHighlightedTextColor),
                  ),
                ),
              );
            } else if (query != "") {
              return AnimationLimiter(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        duration: Duration(seconds: 2),
                        child: FadeInAnimation(
                            duration: Duration(seconds: 2), child: widget)),
                    children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element['PropertyAddress']
                                  .toString()
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              element["State"].toString().toLowerCase() ==
                                  state.toLowerCase() ||
                              element["District"].toString().toLowerCase() ==
                                  district.toLowerCase())
                          .map((QueryDocumentSnapshot<Object?> property) {
                        var isSet = property["isSetImages"].toString();

                        List<String> propertyImages = [];
                        for (int i = 1; i <= 10; i++) {
                          if (property["imgUrl$i"] != "") {
                            propertyImages.add(property["imgUrl$i"]);
                          }
                        }
                        // print(propertyImages);
                        var imageloc = property["imgUrl1"];
                        // print(imageloc);
                        var price = property["Price"];
                        var propertyAddress = property["PropertyAddress"];
                        var propertyName = property["PropertyTitle"];
                        var propertyDescription =
                            property["PropertyDescription"];
                        var to = property["PropertyTo"];
                        var bedRoom = property["BedRoom"];
                        var BathRoom = property["BathRoom"];
                        var propertyCategory = property["PropertyCategory"];
                        var ownerName = property["OwnerName"];
                        var ownerPhno = property["PhNo"];
                        var ownerMail = property["PropertyBy"];
                        var propertyType = property["PropertyType"];
                        var area = property["PlotArea"];
                        var lenght = property["LandLength"];
                        var width = property["LandWidth"];
                        var constructionArea = property["ConstructionArea"];
                        var ownerImgUrl = property["profileImgUrl"];
                        var cent = property["Cent"];
                        var face = property["PropertyDirection"];
                        var state = property["State"];
                        var district = property["District"];
                        return SearchedProperties(
                          state: state,
                          district: district,
                          ownerMail: ownerMail,
                          ownerPhno: ownerPhno,
                          imageloc: imageloc,
                          price: price,
                          propertyAddress: propertyAddress,
                          propertyName: propertyName,
                          propertyImages: propertyImages,
                          propertyCategory: propertyCategory,
                          propertyDescription: propertyDescription,
                          propertyType: propertyType,
                          bedRoom: bedRoom,
                          bathRoom: BathRoom,
                          ownerName: ownerName,
                          to: to,
                          area: area,
                          lenght: lenght,
                          width: width,
                          constructionArea: constructionArea,
                          ownerImgUrl: ownerImgUrl,
                          cent: cent,
                          face: face,
                        );
                      })
                    ],
                  ),
                ),
              );
            } else {
              return AnimationLimiter(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                        duration: Duration(seconds: 2),
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                            duration: Duration(seconds: 2), child: widget)),
                    children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element["State"].toString().toLowerCase() ==
                                  state.toLowerCase() ||
                              element["District"].toString().toLowerCase() ==
                                  district.toLowerCase())
                          .map((QueryDocumentSnapshot<Object?> property) {
                        var isSet = property["isSetImages"].toString();

                        List<String> propertyImages = [];
                        for (int i = 1; i <= 10; i++) {
                          if (property["imgUrl$i"] != "") {
                            propertyImages.add(property["imgUrl$i"]);
                          }
                        }
                        // print(propertyImages);
                        var imageloc = property["imgUrl1"];
                        // print(imageloc);
                        var price = property["Price"];
                        var propertyAddress = property["PropertyAddress"];
                        var propertyName = property["PropertyTitle"];
                        var propertyDescription =
                            property["PropertyDescription"];
                        var to = property["PropertyTo"];
                        var bedRoom = property["BedRoom"];
                        var BathRoom = property["BathRoom"];
                        var propertyCategory = property["PropertyCategory"];
                        var ownerName = property["OwnerName"];
                        var ownerPhno = property["PhNo"];
                        var ownerMail = property["PropertyBy"];
                        var propertyType = property["PropertyType"];
                        var area = property["PlotArea"];
                        var lenght = property["LandLength"];
                        var width = property["LandWidth"];
                        var constructionArea = property["ConstructionArea"];
                        var ownerImgUrl = property["profileImgUrl"];
                        var cent = property["Cent"];
                        var face = property["PropertyDirection"];
                        var state = property["State"];
                        var district = property["District"];
                        return SearchedProperties(
                          state: state,
                          district: district,
                          ownerMail: ownerMail,
                          ownerPhno: ownerPhno,
                          imageloc: imageloc,
                          price: price,
                          propertyAddress: propertyAddress,
                          propertyName: propertyName,
                          propertyImages: propertyImages,
                          propertyCategory: propertyCategory,
                          propertyDescription: propertyDescription,
                          propertyType: propertyType,
                          bedRoom: bedRoom,
                          bathRoom: BathRoom,
                          ownerName: ownerName,
                          to: to,
                          area: area,
                          lenght: lenght,
                          width: width,
                          constructionArea: constructionArea,
                          ownerImgUrl: ownerImgUrl,
                          cent: cent,
                          face: face,
                        );
                      })
                    ],
                  ),
                  
                ),
              );
            }
          }
        });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // final myController = TextEditingController();
    const List<String> States = [
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal'
    ];

    const Map Districts = {
      'Andhra Pradesh': [
        'Anantapur',
        'Chittoor',
        'East Godavari',
        'Alluri Sitarama Raju',
        'Anakapalli',
        'Annamaya',
        'Bapatla',
        'Eluru',
        'Guntur',
        'Kadapa',
        'Kakinada',
        'Konaseema',
        'Krishna',
        'Kurnool',
        'Manyam',
        'N T Rama Rao',
        'Nandyal',
        'Nellore',
        'Palnadu',
        'Prakasam',
        'Sri Balaji',
        'Sri Satya Sai',
        'Srikakulam',
        'Visakhapatnam',
        'Vizianagaram',
        'West Godavari'
      ],
      'Arunachal Pradesh': [
        'Anjaw',
        'Central Siang',
        'Changlang',
        'Dibang Valley',
        'East Kameng',
        'East Siang',
        'Kamle',
        'Kra Daadi',
        'Kurung Kumey',
        'Lepa Rada',
        'Lohit',
        'Longding',
        'Lower Dibang Valley',
        'Lower Siang',
        'Lower Subansiri',
        'Namsai',
        'Pakke Kessang',
        'Papum Pare',
        'Shi Yomi',
        'Tawang',
        'Tirap',
        'Upper Siang',
        'Upper Subansiri',
        'West Kameng',
        'West Siang'
      ],
      'Assam': [
        'Bajali',
        'Baksa',
        'Barpeta',
        'Biswanath',
        'Bongaigaon',
        'Cachar',
        'Charaideo',
        'Chirang',
        'Darrang',
        'Dhemaji',
        'Dhubri',
        'Dibrugarh',
        'Dima Hasao',
        'Goalpara',
        'Golaghat',
        'Hailakandi',
        'Hojai',
        'Jorhat',
        'Kamrup',
        'Kamrup Metropolitan',
        'Karbi Anglong',
        'Karimganj',
        'Kokrajhar',
        'Lakhimpur',
        'Majuli',
        'Morigaon',
        'Nagaon',
        'Nalbari',
        'Sivasagar',
        'Sonitpur',
        'South Salmara-Mankachar',
        'Tinsukia',
        'Udalguri',
        'West Karbi Anglong'
      ],
      'Bihar': [
        'Araria',
        'Arwal',
        'Aurangabad',
        'Banka',
        'Begusarai',
        'Bhagalpur',
        'Bhojpur',
        'Buxar',
        'Darbhanga',
        'East Champaran',
        'Gaya',
        'Gopalganj',
        'Jamui',
        'Jehanabad',
        'Kaimur',
        'Katihar',
        'Khagaria',
        'Kishanganj',
        'Lakhisarai',
        'Madhepura',
        'Madhubani',
        'Munger',
        'Muzaffarpur',
        'Nalanda',
        'Nawada',
        'Patna',
        'Purnia',
        'Rohtas',
        'Saharsa',
        'Samastipur',
        'Saran',
        'Sheikhpura',
        'Sheohar',
        'Sitamarhi',
        'Siwan',
        'Supaul',
        'Vaishali',
        'West Champaran'
      ],
      'Chhattisgarh': [
        'Balod',
        'Baloda Bazar',
        'Balrampur',
        'Bastar',
        'Bemetara',
        'Bijapur',
        'Bilaspur',
        'Dantewada',
        'Dhamtari',
        'Durg',
        'Gariaband',
        'Gaurela Pendra Marwahi',
        'Janjgir Champa',
        'Jashpur',
        'Kabirdham',
        'Kanker',
        'Kondagaon',
        'Korba',
        'Koriya',
        'Mahasamund',
        'Manendragarh',
        'Mohla Manpur',
        'Mungeli',
        'Narayanpur',
        'Raigarh',
        'Raipur',
        'Rajnandgaon',
        'Sakti',
        'Sarangarh Bilaigarh',
        'Sukma',
        'Surajpur',
        'Surguja'
      ],
      'Goa': ['North Goa', 'South Goa'],
      'Gujarat': [
        'Ahmedabad',
        'Amreli',
        'Anand',
        'Aravalli',
        'Banaskantha',
        'Bharuch',
        'Bhavnagar',
        'Botad',
        'Chhota Udaipur',
        'Dahod',
        'Dang',
        'Devbhoomi Dwarka',
        'Gandhinagar',
        'Gir Somnath',
        'Jamnagar',
        'Junagadh',
        'Kheda',
        'Kutch',
        'Mahisagar',
        'Mehsana',
        'Morbi',
        'Narmada',
        'Navsari',
        'Panchmahal',
        'Patan',
        'Porbandar',
        'Rajkot',
        'Sabarkantha',
        'Surat',
        'Surendranagar',
        'Tapi',
        'Vadodara',
        'Valsad'
      ],
      'Haryana': [
        'Ambala',
        'Bhiwani',
        'Charkhi Dadri',
        'Faridabad',
        'Fatehabad',
        'Gurugram',
        'Hisar',
        'Jhajjar',
        'Jind',
        'Kaithal',
        'Karnal',
        'Kurukshetra',
        'Mahendragarh',
        'Mewat',
        'Palwal',
        'Panchkula',
        'Panipat',
        'Rewari',
        'Rohtak',
        'Sirsa',
        'Sonipat',
        'Yamunanagar'
      ],
      'Himachal Pradesh': [
        'Bilaspur',
        'Chamba',
        'Hamirpur',
        'Kangra',
        'Kinnaur',
        'Kullu',
        'Lahaul Spiti',
        'Mandi',
        'Shimla',
        'Sirmaur',
        'Solan',
        'Una'
      ],
      'Jharkhand': [
        'Bokaro',
        'Chatra',
        'Deoghar',
        'Dhanbad',
        'Dumka',
        'East Singhbhum',
        'Garhwa',
        'Giridih',
        'Godda',
        'Gumla',
        'Hazaribagh',
        'Jamtara',
        'Khunti',
        'Koderma',
        'Latehar',
        'Lohardaga',
        'Pakur',
        'Palamu',
        'Ramgarh',
        'Ranchi',
        'Sahebganj',
        'Seraikela Kharsawan',
        'Simdega',
        'West Singhbhum'
      ],
      'Karnataka': [
        'Bagalkot',
        'Bangalore Rural',
        'Bangalore Urban',
        'Belgaum',
        'Bellary',
        'Bidar',
        'Chamarajanagar',
        'Chikkaballapur',
        'Chikkamagaluru',
        'Chitradurga',
        'Dakshina Kannada',
        'Davanagere',
        'Dharwad',
        'Gadag',
        'Gulbarga',
        'Hassan',
        'Haveri',
        'Kodagu',
        'Kolar',
        'Koppal',
        'Mandya',
        'Mysore',
        'Raichur',
        'Ramanagara',
        'Shimoga',
        'Tumkur',
        'Udupi',
        'Uttara Kannada',
        'Vijayanagara',
        'Vijayapura',
        'Yadgir'
      ],
      'Kerala': [
        'Alappuzha',
        'Ernakulam',
        'Idukki',
        'Kannur',
        'Kasaragod',
        'Kollam',
        'Kottayam',
        'Kozhikode',
        'Malappuram',
        'Palakkad',
        'Pathanamthitta',
        'Thiruvananthapuram',
        'Thrissur',
        'Wayanad'
      ],
      'Madhya Pradesh': [
        'Agar Malwa',
        'Alirajpur',
        'Anuppur',
        'Ashoknagar',
        'Balaghat',
        'Barwani',
        'Betul',
        'Bhind',
        'Bhopal',
        'Burhanpur',
        'Chachaura',
        'Chhatarpur',
        'Chhindwara',
        'Damoh',
        'Datia',
        'Dewas',
        'Dhar',
        'Dindori',
        'Guna',
        'Gwalior',
        'Harda',
        'Hoshangabad',
        'Indore',
        'Jabalpur',
        'Jhabua',
        'Katni',
        'Khandwa',
        'Khargone',
        'Maihar',
        'Mandla',
        'Mandsaur',
        'Morena',
        'Narsinghpur',
        'Nagda',
        'Neemuch',
        'Niwari',
        'Panna',
        'Raisen',
        'Rajgarh',
        'Ratlam',
        'Rewa',
        'Sagar',
        'Satna',
        'Sehore',
        'Seoni',
        'Shahdol',
        'Shajapur',
        'Sheopur',
        'Shivpuri',
        'Sidhi',
        'Singrauli',
        'Tikamgarh',
        'Ujjain',
        'Umaria',
        'Vidisha'
      ],
      'Maharashtra': [
        'Ahmednagar',
        'Akola',
        'Amravati',
        'Aurangabad',
        'Beed',
        'Bhandara',
        'Buldhana',
        'Chandrapur',
        'Dhule',
        'Gadchiroli',
        'Gondia',
        'Hingoli',
        'Jalgaon',
        'Jalna',
        'Kolhapur',
        'Latur',
        'Mumbai City',
        'Mumbai Suburban',
        'Nagpur',
        'Nanded',
        'Nandurbar',
        'Nashik',
        'Osmanabad',
        'Palghar',
        'Parbhani',
        'Pune',
        'Raigad',
        'Ratnagiri',
        'Sangli',
        'Satara',
        'Sindhudurg',
        'Solapur',
        'Thane',
        'Wardha',
        'Washim',
        'Yavatmal'
      ],
      'Manipur': [
        'Bishnupur',
        'Chandel',
        'Churachandpur',
        'Imphal East',
        'Imphal West',
        'Jiribam',
        'Kakching',
        'Kamjong',
        'Kangpokpi',
        'Noney',
        'Pherzawl',
        'Senapati',
        'Tamenglong',
        'Tengnoupal',
        'Thoubal',
        'Ukhrul'
      ],
      'Meghalaya': [
        'East Garo Hills',
        'East Jaintia Hills',
        'East Khasi Hills',
        'Mairang',
        'North Garo Hills',
        'Ri Bhoi',
        'South Garo Hills',
        'South West Garo Hills',
        'South West Khasi Hills',
        'West Garo Hills',
        'West Jaintia Hills',
        'West Khasi Hills'
      ],
      'Mizoram': [
        'Aizawl',
        'Champhai',
        'Hnahthial',
        'Kolasib',
        'Khawzawl',
        'Lawngtlai',
        'Lunglei',
        'Mamit',
        'Saiha',
        'Serchhip',
        'Saitual'
      ],
      'Nagaland': [
        'Chumukedima',
        'Dimapur',
        'Kiphire',
        'Kohima',
        'Longleng',
        'Mokokchung',
        'Mon',
        'Noklak',
        'Niuland',
        'Peren',
        'Phek',
        'Tseminyu',
        'Tuensang',
        'Wokha',
        'Zunheboto'
      ],
      'Odisha': [
        'Angul',
        'Balangir',
        'Balasore',
        'Bargarh',
        'Bhadrak',
        'Boudh',
        'Cuttack',
        'Debagarh',
        'Dhenkanal',
        'Gajapati',
        'Ganjam',
        'Jagatsinghpur',
        'Jajpur',
        'Jharsuguda',
        'Kalahandi',
        'Kandhamal',
        'Kendrapara',
        'Kendujhar',
        'Khordha',
        'Koraput',
        'Malkangiri',
        'Mayurbhanj',
        'Nabarangpur',
        'Nayagarh',
        'Nuapada',
        'Puri',
        'Rayagada',
        'Sambalpur',
        'Subarnapur',
        'Sundergarh'
      ],
      'Punjab': [
        'Amritsar',
        'Barnala',
        'Bathinda',
        'Faridkot',
        'Fatehgarh Sahib',
        'Fazilka',
        'Firozpur',
        'Gurdaspur',
        'Hoshiarpur',
        'Jalandhar',
        'Kapurthala',
        'Ludhiana',
        'Malerkotla',
        'Mansa',
        'Moga',
        'Mohali',
        'Muktsar',
        'Pathankot',
        'Patiala',
        'Rupnagar',
        'Sangrur',
        'Shaheed Bhagat Singh Nagar',
        'Tarn Taran'
      ],
      'Rajasthan': [
        'Ajmer',
        'Alwar',
        'Banswara',
        'Baran',
        'Barmer',
        'Bharatpur',
        'Bhilwara',
        'Bikaner',
        'Bundi',
        'Chittorgarh',
        'Churu',
        'Dausa',
        'Dholpur',
        'Dungarpur',
        'Hanumangarh',
        'Jaipur',
        'Jaisalmer',
        'Jalore',
        'Jhalawar',
        'Jhunjhunu',
        'Jodhpur',
        'Karauli',
        'Kota',
        'Nagaur',
        'Pali',
        'Pratapgarh',
        'Rajsamand',
        'Sawai Madhopur',
        'Sikar',
        'Sirohi',
        'Sri Ganganagar',
        'Tonk',
        'Udaipur'
      ],
      'Sikkim': [
        'East Sikkim',
        'North Sikkim',
        'Pakyong',
        'Soreng',
        'South Sikkim',
        'West Sikkim'
      ],
      'Tamil Nadu': [
        'Ariyalur',
        'Chengalpattu',
        'Chennai',
        'Coimbatore',
        'Cuddalore',
        'Dharmapuri',
        'Dindigul',
        'Erode',
        'Kallakurichi',
        'Kanchipuram',
        'Kanyakumari',
        'Karur',
        'Krishnagiri',
        'Madurai',
        'Mayiladuthurai',
        'Nagapattinam',
        'Namakkal',
        'Nilgiris',
        'Perambalur',
        'Pudukkottai',
        'Ramanathapuram',
        'Ranipet',
        'Salem',
        'Sivaganga',
        'Tenkasi',
        'Thanjavur',
        'Theni',
        'Thoothukudi',
        'Tiruchirappalli',
        'Tirunelveli',
        'Tirupattur',
        'Tiruppur',
        'Tiruvallur',
        'Tiruvannamalai',
        'Tiruvarur',
        'Vellore',
        'Viluppuram',
        'Virudhunagar'
      ],
      'Telangana': [
        'Adilabad',
        'Bhadradri Kothagudem',
        'Hyderabad',
        'Jagtial',
        'Jangaon',
        'Jayashankar',
        'Jogulamba',
        'Kamareddy',
        'Karimnagar',
        'Khammam',
        'Komaram Bheem',
        'Mahabubabad',
        'Mahbubnagar',
        'Mancherial',
        'Medak',
        'Medchal',
        'Mulugu',
        'Nagarkurnool',
        'Nalgonda',
        'Narayanpet',
        'Nirmal',
        'Nizamabad',
        'Peddapalli',
        'Rajanna Sircilla',
        'Ranga Reddy',
        'Sangareddy',
        'Siddipet',
        'Suryapet',
        'Vikarabad',
        'Wanaparthy',
        'Warangal',
        'Hanumakonda',
        'Yadadri Bhuvanagiri'
      ],
      'Tripura': [
        'Dhalai',
        'Gomati',
        'Khowai',
        'North Tripura',
        'Sepahijala',
        'South Tripura',
        'Unakoti',
        'West Tripura'
      ],
      'Uttar Pradesh': [
        'Agra',
        'Aligarh',
        'Ambedkar Nagar',
        'Amethi',
        'Amroha',
        'Auraiya',
        'Ayodhya',
        'Azamgarh',
        'Baghpat',
        'Bahraich',
        'Ballia',
        'Balrampur',
        'Banda',
        'Barabanki',
        'Bareilly',
        'Basti',
        'Bhadohi',
        'Bijnor',
        'Budaun',
        'Bulandshahr',
        'Chandauli',
        'Chitrakoot',
        'Deoria',
        'Etah',
        'Etawah',
        'Farrukhabad',
        'Fatehpur',
        'Firozabad',
        'Gautam Buddha Nagar',
        'Ghaziabad',
        'Ghazipur',
        'Gonda',
        'Gorakhpur',
        'Hamirpur',
        'Hapur',
        'Hardoi',
        'Hathras',
        'Jalaun',
        'Jaunpur',
        'Jhansi',
        'Kannauj',
        'Kanpur Dehat',
        'Kanpur Nagar',
        'Kasganj',
        'Kaushambi',
        'Kheri',
        'Kushinagar',
        'Lalitpur',
        'Lucknow',
        'Maharajganj',
        'Mahoba',
        'Mainpuri',
        'Mathura',
        'Mau',
        'Meerut',
        'Mirzapur',
        'Moradabad',
        'Muzaffarnagar',
        'Pilibhit',
        'Pratapgarh',
        'Prayagraj',
        'Raebareli',
        'Rampur',
        'Saharanpur',
        'Sambhal',
        'Sant Kabir Nagar',
        'Shahjahanpur',
        'Shamli',
        'Shravasti',
        'Siddharthnagar',
        'Sitapur',
        'Sonbhadra',
        'Sultanpur',
        'Unnao',
        'Varanasi'
      ],
      'Uttarakhand': [
        'Almora',
        'Bageshwar',
        'Chamoli',
        'Champawat',
        'Dehradun',
        'Haridwar',
        'Nainital',
        'Pauri',
        'Pithoragarh',
        'Rudraprayag',
        'Tehri',
        'Udham Singh Nagar',
        'Uttarkashi'
      ],
      'West Bengal': [
        'Alipurduar',
        'Bankura',
        'Birbhum',
        'Cooch Behar',
        'Dakshin Dinajpur',
        'Darjeeling',
        'Hooghly',
        'Howrah',
        'Jalpaiguri',
        'Jhargram',
        'Kalimpong',
        'Kolkata',
        'Malda',
        'Murshidabad',
        'Nadia',
        'North 24 Parganas',
        'Paschim Bardhaman',
        'Paschim Medinipur',
        'Purba Bardhaman',
        'Purba Medinipur',
        'Purulia',
        'South 24 Parganas',
        'Uttar Dinajpur'
      ]
    };

    void setDistrict(List<String> districtstobeset) {
      setState(() {
        districts = districtstobeset;
        selectedDistrict = 0;
        district = "";
      });
    }

    double _kItemExtent = 32.0;
    int selectedState = 0;
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: kBottomNavigationBackgroundColor,
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: kPageBackgroundColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: TextField(
              controller: myController,
              cursorColor: kHighlightedTextColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  iconColor: kNavigationIconColor,
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   color: kHighlightedTextColor,
                  // ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: kHighlightedTextColor,
                    ),
                    onPressed: () {
                      query = " ";
                      myController.text = "";
                      // print(query);
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
                // print(query);
                buildResults(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 6),
                      child: GestureDetector(
                        onTap: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                selectedState = selectedItem;
                                state = States[selectedState];
                                setDistrict(Districts[state]);
                                buildResults(context);
                              });
                            },
                            children: List<Widget>.generate(States.length,
                                (int index) {
                              return Center(
                                child: Text(
                                  States[index],
                                ),
                              );
                            }),
                          ),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: kHighlightedTextColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Text(
                              "State : " + state,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 6),
                      child: GestureDetector(
                        onTap: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                selectedDistrict = selectedItem;
                                district = districts[selectedDistrict];
                                print(district);
                                buildResults(context);
                              });
                            },
                            children: List<Widget>.generate(districts.length,
                                (int index) {
                              print(districts);
                              return Center(
                                child: Text(
                                  districts[index],
                                ),
                              );
                            }),
                          ),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: kHighlightedTextColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Text(
                              "District : " + district,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Center(
                    child: Text(
                      "Let's see Properties On ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kHighlightedTextColor),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: ToggleButtons(
                    constraints: BoxConstraints(minHeight: 8),
                    fillColor: kHighlightedTextColor,
                    borderWidth: 2,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Rent',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sale',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        searchType =
                            index == 0 ? "PropertiesRent" : "PropertiesSell";
                      });
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    },
                    isSelected: isSelected,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 20,
              child: Stack(children: [
                Opacity(
                  opacity: 0.5,
                  child: Center(
                    child: Container(
                      child: Image(
                        image: AssetImage("images/try10.png"),
                      ),
                    ),
                  ),
                ),
                buildResults(context)
              ]),
            ),
            // BottomPageNavigationBar(
            //   flex_by: 2,
            //   page: searchScreen.id,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: scaffoldBottomAppBar(
        flex_by: 2,
        page: searchScreen.id,
      ),
    );
  }
}

class SearchedProperties extends StatefulWidget {
  final String imageloc;
  final String propertyName;
  final String propertyAddress;
  final String price;
  final String propertyDescription;
  final String to;
  final String ownerName;
  final String ownerMail;
  final String ownerPhno;
  final String propertyType;
  final String bedRoom;
  final String bathRoom;
  final String propertyCategory;
  final String area;
  final String lenght;
  final String width;
  final String constructionArea;
  final String ownerImgUrl;
  final String cent;
  final String face;
  final String state;
  final String district;
  final List<String> propertyImages;
  const SearchedProperties(
      {required this.imageloc,
      required this.ownerMail,
      required this.ownerPhno,
      required this.ownerImgUrl,
      required this.price,
      required this.propertyAddress,
      required this.propertyName,
      required this.bathRoom,
      required this.bedRoom,
      required this.ownerName,
      required this.propertyCategory,
      required this.propertyDescription,
      required this.propertyType,
      required this.to,
      required this.propertyImages,
      required this.lenght,
      required this.width,
      required this.constructionArea,
      required this.cent,
      required this.face,
      required this.state,
      required this.district,
      required this.area});
  @override
  State<SearchedProperties> createState() => _SearchedPropertiesState();
}

class _SearchedPropertiesState extends State<SearchedProperties> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightedTextColor),
          color: kPropertyCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 120,
        // color: kSecondaryButtonColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  cacheManager: customCacheManager,
                  key: UniqueKey(),
                  imageUrl: widget.imageloc,
                  height: 110,
                  width: 110,
                  // maxHeightDiskCache: 230,
                  // maxWidthDiskCache: 190,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: kHighlightedTextColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.black12,
                    child: Icon(
                      Icons.error,
                      color: kHighlightedTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.propertyName,
                      style: TextStyle(
                          color: kHighlightedTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    widget.propertyAddress,
                    style: TextStyle(
                        color: kBottomNavigationBackgroundColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.district + ",\n" + widget.state,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 32, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.price + " \u{20B9}",
                        style: TextStyle(
                            fontSize: 15,
                            color: kHighlightedTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.to == "Rent" ? " / Month" : "",
                        style: TextStyle(
                            fontSize: 10,
                            color: kSubCategoryColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, PropertyDetailsScreen.id);
                          print("ViewDetails Pressed");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetailsScreen(
                                ownerMail: widget.ownerMail,
                                ownerPhoneNo: widget.ownerPhno,
                                type: widget.propertyType,
                                category: widget.propertyCategory,
                                propertyAddress: widget.propertyAddress,
                                propertyTitle: widget.propertyName,
                                to: widget.to,
                                ownerName: widget.ownerName,
                                propertyDescription: widget.propertyDescription,
                                noBathroom: widget.bathRoom,
                                noBedroom: widget.bedRoom,
                                area: widget.area,
                                propertyImages: widget.propertyImages,
                                price: widget.price,
                                lenght: widget.lenght,
                                width: widget.width,
                                constructionArea: widget.constructionArea,
                                ownerImgUrl: widget.ownerImgUrl,
                                cent: widget.cent,
                                face: widget.face,
                                state: widget.state,
                                district: widget.district,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'View Details',
                          style: TextStyle(color: kPrimaryButtonColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
