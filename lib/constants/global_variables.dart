import 'package:flutter/material.dart';

//global variable
//home
String uri = 'http://192.168.1.69:3000';

//Pokhara home addressz
// String uri = 'http://172.16.12.165:3000';
// String uri = 'https://bloodlink.cyclic.app';

//adarsh
// String uri = 'http://172.20.10.3:3000';

//adarsh home
// String uri = 'http://192.168.1.68:3000';

//kantipur
// String uri = 'http://192.168.0.124:3000';
// String uri = 'http://192.168.1.64:3000';


// mobile data network
// String uri = 'http://172.20.10.4:3000';


class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 204, 37, 76),
      Color.fromARGB(255, 189, 14, 55),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const titleColor = Color.fromARGB(255, 160, 43, 19);
  static const dataDisplayColor = Color.fromARGB(255, 175, 14, 14);
  static const pageTitleColor = Color.fromARGB(255, 112, 22, 22);
  static const buttonBackgroundColor = Color.fromARGB(255, 216, 0, 50);
  static const loginSignUpButtonBackgroundColor =
      Color.fromARGB(255, 212, 29, 72);
  static const appBarColor = Color.fromARGB(255, 201, 25, 66);
  static const dividerColor = Color.fromARGB(59, 0, 0, 0);
static const khaltiAppColor = Color.fromARGB(255,94,61,142);
  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://img.freepik.com/free-psd/blood-donation-banner-template_23-2149084554.jpg?w=360',
    'https://img.freepik.com/free-psd/blood-donation-banner-template_23-2149095055.jpg',
    'https://img.freepik.com/free-vector/gradient-world-blood-donor-day-horizontal-banner-template_23-2149413231.jpg?w=2000',
    'https://img.freepik.com/free-vector/happy-world-blood-donor-day-red-grey-yellow-background-social-media-design-banner-free-vector_1340-21612.jpg',
    'https://img.freepik.com/free-vector/world-blood-donor-day-realistic-banner_23-2149393884.jpg?w=2000',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
