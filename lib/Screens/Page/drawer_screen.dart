import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Page/drawer_screen.dart';
import 'package:mobile_application/Screens/Page/home_screen.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:flutter/cupertino.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFA0C2A5),
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Too-Yen',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  FlatButton(
                      //color: Colors.red[300],
                      child: Text("Home",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      onPressed: () => navigateToHomePage(context)),
                ]),

                Row(children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 25,
                  ),
                  FlatButton(
                      //color: Colors.red[300],
                      child: Text("Add",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      onPressed: () => navigateToAddPage(context)),
                ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.list_alt,
                    color: Colors.black,
                    size: 25,
                  ),
                  FlatButton(
                      //color: Colors.red[300],
                      child: Text("Buying list",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      onPressed: () => navigateToAddPage(context)),
                ]),

                // Row(children: <Widget>[
                //   Icon(
                //     Icons.home_outlined,
                //     color: Colors.black,
                //     size: 25,
                //   ),
                //   SizedBox(
                //     width: 20,
                //   ),
                //   Text(
                //     'home',
                //     style: TextStyle(color: Colors.black, fontSize: 17),
                //   ),
                // ]),
                // FlatButton(
                //     //color: Colors.red[300],
                //     Icons.home_outlined,
                //     child: Text("Go to Home page",
                //         style: TextStyle(color: Colors.black, fontSize: 17)),
                //     onPressed: () => navigateToHomePage(context)),

                // NewRow(
                //   text: 'Home',
                //   icon: Icons.home_outlined,
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                // NewRow(text: 'Add', icon: Icons.add),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
            Row(
              children: <Widget>[
                // Icon(
                //   Icons.cancel,
                //   color: Colors.black.withOpacity(0.5),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                // Text(
                //   'Log out',
                //   style: TextStyle(
                //       color: Colors.black.withOpacity(0.5), fontSize: 17),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

navigateToHomePage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) {
    return RouteHome();
  }));
}

navigateToAddPage(BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) {
    return RouteAdd();
  }));
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black,
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
