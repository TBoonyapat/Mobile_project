import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/components/configuration.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application/noti/notification_service.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationManager noti = NotificationManager();
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;
  void initState() {
    super.initState();
    Provider.of<TooyenProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? 0 : 0),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          //color: Color(0xFFA0C2A5),
          borderRadius: isDrawerOpen
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
        ),
        child: ListView(children: [
          Column(
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
                            child:
                                Icon(Icons.arrow_back_ios, color: Colors.black),
                            onTap: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : GestureDetector(
                            child: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 200;
                                yOffset = 80;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      'Too-Yen',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 110,
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
                                child: Image.asset(
                                    categories[index]['iconPath'],
                                    height: 55,
                                    width: 55),
                                onPressed: () => null),
                            //color: Colors.grey[700],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            categories[index]['name'],
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ) //ปรับตำแหน่งตัวอักษรด้วย
                        ],
                      ),
                    );
                  },
                ),
              ),
              Consumer(
                  builder: (context, TooyenProvider provider, Widget child) {
                var count = provider.tooyenList.length; //นับจำนวนข้อมูล
                if (count <= 0) {
                  return Center(
                    child: Text(
                      "Empty",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                      height: 500,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, int index) {
                            Tooyen data = provider.tooyenList[index];
                            return GestureDetector(
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: shadowList,
                                            ),
                                            margin: EdgeInsets.only(top: 50),
                                          ),
                                          Align(
                                            alignment: Alignment(0.0, 0.5),
                                            child: Hero(
                                                tag: 1,
                                                child: Image.asset(data.imgPath,
                                                    height: 130,
                                                    width: 130,
                                                    fit: BoxFit
                                                        .fitWidth)), //ปรับขนาด
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      //กรอบ2(สีขาว)
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 60, bottom: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: shadowList,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                          ),
                                          Align(
                                            alignment: Alignment(-0.8, -0.1),
                                            child: Text(
                                              data.name,
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-0.7, 0.45),
                                            child: Text(
                                              'EXP : ' +
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(data.date),
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-0.7, 0.27),
                                            child: Text(
                                              'Catrgory : ' + data.category,
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            //ทำให้อยู่ในช่องที่สร้างข้างบน
                                            alignment: Alignment(-0.9, 0.70),
                                            child: new LinearPercentIndicator(
                                              width: 160.0,
                                              lineHeight: 15.0,
                                              percent: 0.6,
                                              center: Text(
                                                "50.0%",
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              progressColor: Colors.red[300],
                                            ),
                                          ),
                                          Align(
                                            //ทำให้อยู่ในช่องที่สร้างข้างบน
                                            alignment: Alignment(1.5, -0.40),
                                            child: FlatButton(
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.black45,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  provider.delIng(data.id);
                                                  noti.removeReminder(data.id);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          fullscreenDialog:
                                                              true,
                                                          builder: (context) {
                                                            return RouteHome();
                                                          }));
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                }
              }),

              // GestureDetector(
              //   child: Container(
              //     height: 220,
              //     margin: EdgeInsets.symmetric(horizontal: 20),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           //กรอบ1(สีเทา)
              //           child: Stack(
              //             children: [
              //               Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   // color: Colors.blueGrey[300],
              //                   borderRadius: BorderRadius.circular(20),
              //                   boxShadow: shadowList,
              //                 ),
              //                 margin: EdgeInsets.only(top: 50),
              //               ),
              //               Align(
              //                 child: Hero(
              //                     tag: 1,
              //                     child: Image.asset('assets/images/monkey.png')),
              //                 //child: Image.asset('assets/images/monkey.png')),
              //               )
              //             ],
              //           ),
              //         ),
              //         Expanded(
              //           //กรอบ2(สีขาว)
              //           child: Stack(
              //             children: [
              //               Container(
              //                 margin: EdgeInsets.only(top: 60, bottom: 20),
              //                 decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     boxShadow: shadowList,
              //                     borderRadius: BorderRadius.only(
              //                         topRight: Radius.circular(20),
              //                         bottomRight: Radius.circular(20))),
              //               ),
              //               // Align(
              //               //   child: Text('ผัก'),
              //               // ),
              //               Align(
              //                 //ทำให้อยู่ในช่องที่สร้างข้างบน
              //                 alignment: Alignment(2.0, 0.65),
              //                 child: new LinearPercentIndicator(
              //                   width: 140.0,
              //                   lineHeight: 15.0,
              //                   percent: 0.5,
              //                   center: Text(
              //                     "50.0%",
              //                     style: TextStyle(
              //                       color: Colors.black54,
              //                       fontSize: 11,
              //                     ),
              //                   ),
              //                   progressColor: Colors.red[300],
              //                   //backgroundColor: Colors.green[300],
              //                 ),
              //               ),
              //               Align(
              //                 //ทำให้อยู่ในช่องที่สร้างข้างบน
              //                 alignment: Alignment(1.50, 0.75),
              //                 child: FlatButton(
              //                     child: Icon(
              //                       Icons.delete,
              //                       color: Colors.red[900],
              //                       size: 30,
              //                     ),
              //                     onPressed: () => null),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              //Test(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_application/Screens/Page/configuration.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:mobile_application/models/tooyen.dart';
// import 'package:mobile_application/providers/tooyen_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/services.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double xOffset = 0;
//   double yOffset = 0;

//   bool isDrawerOpen = false;
//   void initState() {
//     super.initState();
//     Provider.of<TooyenProvider>(context, listen: false).initData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//     AnimatedContainer(
//       transform: Matrix4.translationValues(xOffset, yOffset, 0)
//         ..scale(isDrawerOpen ? 0.85 : 1.00)
//         ..rotateZ(isDrawerOpen ? -50 : 0),
//       duration: Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius:
//             isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
//       ),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
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
//                             xOffset = 290;
//                             yOffset = 80;
//                             isDrawerOpen = true;
//                           });
//                         },
//                       ),
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
//             height: 40,
//           ),
//           Container(
//             height: 100,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.only(left: 10),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: shadowList,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: FlatButton(
//                             child: Image.asset(categories[index]['iconPath'],
//                                 height: 55, width: 55),
//                             onPressed: () => null),
//                         //color: Colors.grey[700],
//                       ),
//                       Text(categories[index]['name']) //ปรับตำแหน่งตัวอักษรด้วย
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           GestureDetector(
//             child: Container(
//               height: 220,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     //กรอบ1(สีเทา)
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFFA0C2A5),
//                             // color: Colors.blueGrey[300],
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: shadowList,
//                           ),
//                           margin: EdgeInsets.only(top: 50),
//                         ),
//                         Align(
//                           child: Hero(
//                               tag: 1,
//                               child: Image.asset('assets/images/monkey.png')),
//                           //child: Image.asset('assets/images/monkey.png')),
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     //กรอบ2(สีขาว)
//                     child: Stack(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 60, bottom: 20),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: shadowList,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(20),
//                                   bottomRight: Radius.circular(20))),
//                         ),
//                         // Align(
//                         //   child: Text('ผัก'),
//                         // ),
//                         Align(
//                           //ทำให้อยู่ในช่องที่สร้างข้างบน
//                           alignment: Alignment(2.0, 0.65),
//                           child: new LinearPercentIndicator(
//                             width: 140.0,
//                             lineHeight: 15.0,
//                             percent: 0.5,
//                             center: Text(
//                               "50.0%",
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 11,
//                               ),
//                             ),
//                             progressColor: Colors.red[300],
//                             //backgroundColor: Colors.green[300],
//                           ),
//                         ),
//                         Align(
//                           //ทำให้อยู่ในช่องที่สร้างข้างบน
//                           alignment: Alignment(1.50, 0.75),
//                           child: FlatButton(
//                               child: Icon(
//                                 Icons.delete,
//                                 color: Colors.red[900],
//                                 size: 30,
//                               ),
//                               onPressed: () => null),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Expanded(
//                   //     child: Stack(
//                   //   children: <Widget>[
//                   //     new LinearPercentIndicator(
//                   //       width: 100.0,
//                   //       lineHeight: 8.0,
//                   //       percent: 0.2,
//                   //       progressColor: Colors.red,
//                   //     ),
//                   //   ],
//                   // )),
//                 ],
//               ),
//             ),
//           ),
//           //Test(),
//           SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
//   }
// }

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Consumer(
//       builder: (context, TooyenProvider provider, Widget child) {
//         var count = provider.tooyenList.length; //นับจำนวนข้อมูล
//         if (count <= 0) {
//           return Center(
//             child: Text(
//               "ไม่พบข้อมูล",
//               style: TextStyle(fontSize: 35),
//             ),
//           );
//         } else {
//           return ListView.builder(
//               itemCount: count,
//               itemBuilder: (context, int index) {
//                 Tooyen data = provider.tooyenList[index];
//                 return Card(
//                   elevation: 5,
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                       child: FittedBox(
//                         child: Text(data.category),
//                       ),
//                     ),
//                     title: Text(data.name),
//                     subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
//                   ),
//                 );
//               });
//         }
//       },
//     ));
//   }
// }
