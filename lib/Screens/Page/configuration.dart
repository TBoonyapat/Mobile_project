import 'package:flutter/material.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Fox', 'iconPath': 'assets/images/fox.png'},
  {'name': 'Fish', 'iconPath': 'assets/images/fish.png'},
  {'name': 'Cat', 'iconPath': 'assets/images/cat.png'},
  {'name': 'Dog', 'iconPath': 'assets/images/dog.png'},
  {'name': 'Owl', 'iconPath': 'assets/images/owl.png'}
];

List<Map> drawerItems=[
  {
    'icon': Icons.home,
    'title' : 'Home'
  },
  {
    'icon': Icons.add,
    'title' : 'Add'
  },
];