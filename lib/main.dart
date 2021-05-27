import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Login/login_screen.dart';
import 'package:mobile_application/Screens/home.dart';
import 'package:mobile_application/constants.dart';
// import 'package:mobile_application/DateTimePicker.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:mobile_application/Screens/Page/add_from.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:mobile_application/Screens/Login/login_screen.dart';
import 'package:mobile_application/constants.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TooyenProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Tooyen'),
      ),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: 
        TabBarView(
          children: [RouteHome(),RouteAdd()],
        ),
        // bottomNavigationBar: TabBar(
        //   tabs: [
        //     Tab(
        //       icon: Icon(Icons.list),
        //       text: "Home",
        //     ),
        //     Tab(
        //       icon: Icon(Icons.add),
        //       text: "Add"
        //       )
        //   ],
        // ),
      ),
    );
  }
}
