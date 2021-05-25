import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Page/add_from.dart';
import './Home/drawer_screen.dart';
import '../Screens/Page/home_screen.dart';

class RouteHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //SideBarLayout()
          DrawerScreen(),
          HomeScreen(),
          //AddFrom()
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