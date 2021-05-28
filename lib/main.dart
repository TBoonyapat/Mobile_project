import 'package:flutter/material.dart';


import 'package:mobile_application/constants.dart';

import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/providers/todo_provider.dart';
import 'package:provider/provider.dart';

import 'package:mobile_application/Screens/sidebar_layout.dart';





void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<TooyenProvider>(
        create: (_) => TooyenProvider(),
      ),
      ChangeNotifierProvider<TodoProvider>(
        create: (_) => TodoProvider(),
      ),
        
        
      ],
      child: MaterialApp(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Tooyen'),
      ),
    );
  }
}


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
        
      ),
    );
  }
}
