import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Page/configuration.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isDrawerOpen
                    ? GestureDetector(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            isDrawerOpen = false;
                          });
                        },
                      )
                    : GestureDetector(
                        child: Icon(Icons.menu),
                        onTap: () {
                          setState(() {
                            xOffset = 290;
                            yOffset = 80;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                Text(
                  'Too-Yen',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                Container(),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                            child: Image.asset(categories[index]['iconPath'],
                                height: 55, width: 55),
                            onPressed: () => null),
                            //color: Colors.grey[700],
                      ),
                      Text(categories[index]['name']) //ปรับตำแหน่งตัวอักษรด้วย
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            child: Container(
              height: 220,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    //กรอบ1(สีเทา)
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFA0C2A5),
                            // color: Colors.blueGrey[300],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        Align(
                          child: Hero(
                              tag: 1,
                              child: Image.asset('assets/images/monkey.png')),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    //กรอบ2(สีขาว)
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60, bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ),
                        // Align(
                        //   child: Text('ผัก'),
                        // ),
                        Align(
                          //ทำให้อยู่ในช่องที่สร้างข้างบน
                          alignment: Alignment(2.0, 0.65),
                          child: new LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 15.0,
                            percent: 0.5,
                            center: Text(
                              "50.0%",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11,
                              ),
                            ),
                            progressColor: Colors.red[300],
                            backgroundColor: Colors.green[300],
                          ),
                        ),
                        Align(
                          //ทำให้อยู่ในช่องที่สร้างข้างบน
                          alignment: Alignment(1.50, 0.75),
                          child: FlatButton(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red[900],
                                size: 30,
                              ),
                              onPressed: () => null),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //     child: Stack(
                  //   children: <Widget>[
                  //     new LinearPercentIndicator(
                  //       width: 100.0,
                  //       lineHeight: 8.0,
                  //       percent: 0.2,
                  //       progressColor: Colors.red,
                  //     ),
                  //   ],
                  // )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_application/Screens/Page/configuration.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double xOffset = 0;
//   double yOffset = 0;

//   bool isDrawerOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       transform: Matrix4.translationValues(xOffset, yOffset, 0)
//         ..scale(isDrawerOpen ? 0.85 : 1.00)
//         ..rotateZ(isDrawerOpen ? -50 : 0),
//       duration: Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: isDrawerOpen
//               ? BorderRadius.circular(40)
//               : BorderRadius.circular(0)),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//              margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 isDrawerOpen
//                     ? GestureDetector(
//                         child: Icon(Icons.arrow_back_ios),
//                         onTap: () {
//                           setState(() {
//                             xOffset = 0;
//                             yOffset = 0;
//                             isDrawerOpen = false;
//                           });
//                         },
//                       )
//                     : GestureDetector(
//                         child: Icon(Icons.menu),
//                         onTap: () {
//                           setState(() {
//                             xOffset = 230;
//                             yOffset = 150;
//                             isDrawerOpen = true;
//                           });
//                         }),
//                 Text(
//                   'Too-Yen',
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       decoration: TextDecoration.none),
//                 ),
//                 Container(),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 120,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.only(left: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: shadowList,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Image.asset(
//                           categories[index]['iconPath'],
//                           height: 50,
//                           width: 50,
//                           //color: Colors.grey[700],
//                         ),
//                       ),
//                       Text(categories[index]['name']) //ปรับตำแหน่งตัวอักษรด้วย
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),

//           GestureDetector(
//             // onTap: () {
//             //   Navigator.push(context,
//             //       MaterialPageRoute(builder: (context) => Screen2()));
//             // },
//             child: Container(
//               height: 210,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     //กรอบ1(สีเทา)
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.blueGrey[300],
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: shadowList,
//                           ),
//                           margin: EdgeInsets.only(top: 50),
//                         ),
//                         Align(
//                           child: Hero(
//                               tag: 1,
//                               child: Image.asset('assets/images/turtle.png')),
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                       //กรอบ2(สีขาว)
//                       child: Container(
//                     margin: EdgeInsets.only(top: 60, bottom: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: shadowList,
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(20),
//                             bottomRight: Radius.circular(20))),
//                   ))
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
//   }
// }
