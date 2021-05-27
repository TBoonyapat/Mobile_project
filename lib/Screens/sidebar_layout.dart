import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Page/add_from.dart';
import 'Page/drawer_screen.dart';
import '../Screens/Page/home_screen.dart';
import 'package:mobile_application/Screens/Page/buying_list.dart';
import '../Screens/home.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mobile_application/DateTimePicker.dart';

class RouteHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //SideBarLayout()
          DrawerScreen(),
          //Home()
          HomeScreen()
          //DateTimePicker()
          //Home(),
          // AddFrom()
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

// body: Center(
//   child: ElevatedButton(
//      child: Text('Open route'),
//      onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => DrawerScreen()),
//       );
//     },
//   )
// ),

// body: BlocProvider<NavigationBloc>(
//   create: (context) => NavigationBloc(),
//   child: Stack(
//     children: <Widget>[
//       BlocBuilder<NavigationBloc, NavigationStates>(
//         builder: (context, navigationState) {
//           return navigationState as Widget;
//         },
//       ),
//       DrawerScreen(),
//     ],
//   ),
// ),
