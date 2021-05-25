import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:mobile_application/Screens/Login/components/background.dart';
import 'package:mobile_application/Screens/Login/login_screen.dart';
import 'package:mobile_application/Screens/Signup/signup_screen.dart';

import 'package:mobile_application/components/rounded_button.dart';
import 'package:mobile_application/components/rounded_input_field.dart';
import 'package:mobile_application/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/databases/tooyen_db.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TooyenProvider>(context,listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text("Tooyen"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                    SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TooyenProvider provider, Widget child) {
            var count = provider.tooyenList.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Tooyen data = provider.tooyenList[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(data.category),
                          ),
                        ),
                        title: Text(data.name),
                        subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}