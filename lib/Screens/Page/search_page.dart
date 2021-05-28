import 'package:flutter/material.dart';
import 'package:mobile_application/components/text_field_container.dart';
import 'package:mobile_application/Screens/constants.dart';
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

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _findValue;
  final NotificationManager noti = NotificationManager();
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  void initState() {
    _findValue = '';
    Provider.of<TooyenProvider>(context, listen: false)
        .findIngredient(widget.title);

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
                  'Search Result',
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedInputField(
                  hintText: "Search ingredient name...",
                  onChanged: (value) {
                    _findValue = value;
                  },
                  //icon: Icons.search,
                ),
                FlatButton(
                  child: Icon(
                    Icons.search,
                    color: Colors.black45,
                    size: 20,
                  ),
                  onPressed: () => navigateToSearchPage(context, _findValue),
                ),
              ],
            ),
          ),
          //ส่วนแสดง
          Consumer(
            builder: (context, TooyenProvider provider, Widget child) {
              var count = provider.findList.length; //นับจำนวนข้อมูล
              if (count <= 0) {
                return Center(
                  child: Text(
                    'No "'+ widget.title+'" in Too Yen',
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
                      Tooyen data = provider.findList[index];
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
                                        borderRadius: BorderRadius.circular(20),
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
                                              fit: BoxFit.fitWidth)), //ปรับขนาด
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                //กรอบ2(สีขาว)
                                child: Stack(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 60, bottom: 20),
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
                                              decoration: TextDecoration.none),
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

navigateToSearchPage(BuildContext context, String cate) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) {
    return RouteSearch(cate: cate);
  }));
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
          hintText: hintText,
          border: InputBorder.none,
          // icon: Icon(
          //   icon,
          //   color: kPrimaryColor,
          // ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: _width / 1.4,
      height: _height / 15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
