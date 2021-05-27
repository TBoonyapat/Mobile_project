import 'package:flutter/material.dart';
import 'package:mobile_application/components/text_field_container.dart';
import 'package:mobile_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application/noti/notification_service.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class AddFrom extends StatefulWidget {
  @override
  _AddFromState createState() => _AddFromState();
}

class _AddFromState extends State<AddFrom> {
  final formKey = GlobalKey<FormState>();
  final NotificationManager noti = NotificationManager();
  double xOffset = 0;
  double yOffset = 0;
  String _chosenValue;
  String _categoryValue;
  double _height;
  double _width;
  String _ingredientsValue;
  String _setTime, _setDate;
  DateTime exp_date;
  String _hour, _minute, _time;
  var uuid = Uuid();
  bool isDrawerOpen = false;
  Random random = new Random();
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        // exp_date = selectedDate;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void initState() {
    _ingredientsValue = '';
    _dateController.text =
        DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)));
    _categoryValue = "meat";
    _timeController.text = "00 : 00";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

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
      // child: SingleChildScrollView(
      child: Form(
        key: formKey,
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
                    'Add Ingredients',
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
            Column(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/ing.svg",
                  height: size.height * 0.24,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment(-0.52, 0.75),
                  child: Text(
                    "Name's Ingredients",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // style: TextStyle(
                    //     fontSize: 17, color: Colors.black, letterSpacing: 0.5),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    RoundedInputField(
                      hintText: "example: egg/milk...",
                      icon: Icons.add,
                      onChanged: (value) {
                        setState(() {
                          _ingredientsValue = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-0.25, 0.75),
                      child: Text(
                        'Expiration Date : mm-dd-yyyy',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        width: _width / 1.5,
                        height: _height / 15,
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          onSaved: (String val) {
                            _setDate = val;
                          },
                          decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.only(top: 0.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment(-0.64, 0.75),
                  child: Text(
                    'Category',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: DropdownButton<String>(
                    value: _categoryValue,
                    // underline: Container(
                    //   color: Colors.blue,
                    // ),
                    //dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20.0,
                    iconEnabledColor: kPrimaryColor,
                    items: <String>[
                      'vegetables',
                      'meat',
                      'fruit',
                      'skincare',
                      'egg',
                      'seasoning',
                      'dessert',
                      'drink'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _categoryValue = value;
                        _ingredientsValue = _ingredientsValue;
                      });
                    },
                  ),
                ),
                // SizedBox(
                //   height: 36,
                // ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: _width / 2,
                      height: _height / 14,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            color: kPrimaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            textColor: Colors.white,
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                var name = _ingredientsValue;
                                var category = _categoryValue;
                                var now = new DateTime.now();
                                Random rnd1 = new Random(selectedDate.year);
                                Random rnd2 =
                                    new Random(now.millisecondsSinceEpoch);
                                int rnd3 = rnd2.nextInt(100000000);
                                int rnd4 = rnd1.nextInt(100000000);
                                int _id = rnd4 + rnd3;

                                //เตรียมข้อมูล
                                Tooyen tooyenList = Tooyen(
                                    id: _id,
                                    name: name,
                                    category: category,
                                    date: selectedDate,
                                    imgPath:
                                        "assets/images/" + category + ".png"
                                    // date: DateTime.now()
                                    ); //object

                                //เรียก Provider
                                var provider = Provider.of<TooyenProvider>(
                                    context,
                                    listen: false);
                                provider.addTooyen(tooyenList);
                                noti.showNotificationDaily(
                                    _id, name, selectedDate);
                                //  manager.showNotificationDaily(tooyenList.id, name, Datetime.now());
                                //provider.delTooyen();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) {
                                          return RouteHome();
                                        }));
                              }
                            },
                          )),
                    ),
                  ],
                ),
                //   RoundedButton(
                //       text: "Add", press: () {}, color: Color(0xFF5F9D6E)),
              ],
            )
          ],
        ),
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

