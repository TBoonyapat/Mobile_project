import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:mobile_application/Screens/Home/drawer_screen.dart';
import 'package:mobile_application/Screens/Page/home_screen.dart';
import 'package:mobile_application/Screens/Page/add_from.dart';
// import 'package:mobile_application/Screens/Login/login_screen.dart';
// import 'package:mobile_application/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            RouteHome()
            //DrawerScreen(),
            //AddFrom()
            //HomeScreen(),
          ],
        ),
      ),
      // getPages: [
      //   GetPage(
      //     name: '/home',
      //     page: () => HomeScreen(),
      //   )
      // ],
    );
  }
}
//       title: 'Flutter Auth',
//       theme: ThemeData(
//         primaryColor: kPrimaryColor,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
