import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:mobile_application/components/configuration.dart';

import 'package:provider/provider.dart';
import 'package:mobile_application/models/tooyen.dart';

import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:mobile_application/noti/notification_service.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotificationManager noti = NotificationManager();
  double xOffset = 0;
  double yOffset = 0;
 
  bool isDrawerOpen = false;
  @override
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
          
          borderRadius: isDrawerOpen
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
        ),
        child: ListView(
            
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
                                xOffset = 200;
                                yOffset = 80;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      'Too-Yen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
                                child: Image.asset(
                                    categories[index]['iconPath'],
                                    height: 55,
                                    width: 55),
                                onPressed: () => null),
                            
                          ),
                          Text(categories[index]
                              ['name']) //?????????????????????????????????????????????????????????????????????
                        ],
                      ),
                    );
                  },
                ),
              ),
              Consumer(
                  builder: (context, TooyenProvider provider, Widget child) {
                var count = provider.tooyenList.length; //??????????????????????????????????????????
                if (count <= 0) {
                  return Center(
                    child: Text(
                      "?????????????????????????????????",
                      style: TextStyle(fontSize: 35),
                    ),
                  );
                } else {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: count,
                      itemBuilder: (context, int index) {
                        Tooyen data = provider.tooyenList[index];

                        return Container(
                            child: GestureDetector(
                          child: Container(
                            
                            height: 220,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  //????????????1(???????????????)
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: shadowList,
                                        ),
                                        margin: EdgeInsets.only(top: 50),
                                      ),
                                      Align(
                                        child: Hero(
                                            tag: 1,
                                            child: Image.asset(data.imgPath)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  //????????????2(???????????????)

                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 60, bottom: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: shadowList,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20))),
                                      ),
                                      Align(
                                        child: Text(DateFormat("dd/MM/yyyy")
                                            .format(data.date)),
                                      ),
                                      Align(
                                        //???????????????????????????????????????????????????????????????????????????????????????

                                        alignment: Alignment(2.0, 0.65),
                                        child: new LinearPercentIndicator(
                                          width: 100.0,
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
                                          
                                        ),
                                      ),
                                      Align(
                                        //???????????????????????????????????????????????????????????????????????????????????????
                                        alignment: Alignment(1.50, 0.75),
                                        child: FlatButton(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red[900],
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              provider.delIng(data.id);
                                              noti.removeReminder(data.id);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      fullscreenDialog: true,
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
                        ));
                      });
                }
              })
            ]),
      ),

  
    );

 
  }
}

