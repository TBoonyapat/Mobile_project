import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Page/add_from.dart';
import 'Page/drawer_screen.dart';
import '../Screens/Page/home_screen.dart';
import 'package:mobile_application/Screens/Page/buying_list.dart';
import 'package:mobile_application/Screens/Page/category_screen.dart';


class RouteHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [     
          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}

class RouteAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          AddFrom(),
        ],
      ),
    );
  }
}

class RouteBuying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          BuyingList(),
        ],
      ),
    );
  }
}

class RouteCategory extends StatelessWidget {
   const RouteCategory({
    Key key,
    @required this.cate,
  }) : super(key: key);
  final String cate;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          CategoryScreen(title : cate),
        ],
      ),
    );
  }
}


