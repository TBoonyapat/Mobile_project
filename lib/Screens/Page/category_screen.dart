import 'package:flutter/material.dart';
import 'package:mobile_application/components/text_field_container.dart';
import 'package:mobile_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


import 'package:flutter/cupertino.dart';
import 'package:mobile_application/noti/notification_service.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_application/components/configuration.dart';
import 'package:percent_indicator/percent_indicator.dart';


class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  
  
  final NotificationManager noti = NotificationManager();
  double xOffset = 0;
  double yOffset = 0;
 

 
  bool isDrawerOpen = false;


  

  @override
  void initState() {
    
    Provider.of<TooyenProvider>(context, listen: false).initCategory(widget.title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? 0 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
     
      
        
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
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
                    widget.title,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: FlatButton(
                                child: Image.asset(
                                    categories[index]['iconPath'],
                                    height: 55,
                                    width: 55),
                                onPressed: () =>
                                    navigateToCategoryPage(context,categories[index]['name'])),
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
                  var count = provider.cateList.length; //นับจำนวนข้อมูล
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
                          Tooyen data = provider.cateList[index];
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
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
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
                                            width: 170.0,
                                            lineHeight: 15.0,
                                            percent: 0.9,
                                            center: Text(
                                              "อีก 1 วัน",
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
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
                                                      fullscreenDialog: true,
                                                      builder: (context) {
                                                        return RouteHome();
                                                      }));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      

      // ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

navigateToCategoryPage(BuildContext context, String cate) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) {
    return RouteCategory(cate : cate);
  }));
}