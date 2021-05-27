// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


import 'package:mobile_application/Screens/home.dart';

import 'package:mobile_application/components/rounded_input_field.dart';

import 'package:flutter_svg/svg.dart';
import 'package:mobile_application/constants.dart';
import 'package:mobile_application/main.dart';
import 'package:provider/provider.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/noti/notification_service.dart';

class DateTimePicker extends StatefulWidget {
  
  // final NotificationManager noti =  NotificationManager();
  // const DateTimePicker ({ Key key, this.noti }): super(key: key);
 

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final formKey = GlobalKey<FormState>();
 
  final NotificationManager noti =  NotificationManager();
  String _categoryValue;
  double _height;
  double _width;
  // final ingredientsController = TextEditingController();//รับค่าชื่อรายการ
  String _ingredientsValue ;
  String _setTime, _setDate;
  DateTime exp_date;
  String _hour, _minute, _time;
  var uuid = Uuid();

  // String dateTime;

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
    _dateController.text = DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)));
    _categoryValue = "meat" ;
    _timeController.text = "00 : 00";
    
    // format(
    //     DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //     [hh, ':', nn, " ", am]).toString();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    // dateTime = DateFormat.yMd().format(DateTime.now());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add new ingredients'),
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        width: _width,
        height: _height,
        child : Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget> [
              // SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/ing.svg",
                height: size.height * 0.2,
              ),
              // SizedBox(height: size.height * 0.001),
              Text(
                  'ชื่อวัตถุดิบ',
                  style: TextStyle(
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
              RoundedInputField(
              
              hintText: "เช่น เนื้อหมู,นมวัว...",
              
              onChanged: (value) {
                setState(() {
                _ingredientsValue = value;
              });
              },
            ),
              Text(
                  'หมวดหมู่วัตถุดิบ',
                  style: TextStyle(
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),

              DropdownButton<String>(
                    value: _categoryValue,
                    underline: Container(
                        // underline can be styled as well
                        // height: 4.0,
                        color: Colors.blue,
                        ), // this removes underline
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20.0, // can be changed, default: 24.0
                    iconEnabledColor: kPrimaryColor,
                    items: <String>['vegetables', 'meat', 'fruit', 'skincare','egg','seasoning','dessert','drink']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _categoryValue = value;
                        _ingredientsValue = _ingredientsValue;
                      });
                    },
                    
                  ),
                
            Column(
              children: <Widget>[
                Text(
                  'วันที่หมดอายุ : เดือน-วัน-ปี',
                  style: TextStyle(
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 2,
                    height: _height / 15,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: _width / 2,
                      height: _height / 14,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                  child: Text("เพิ่มข้อมูล"),
                  color: kPrimaryColor,
                  
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  textColor: Colors.white,
                  onPressed: (){
                      if(formKey.currentState.validate()){
                          var name = _ingredientsValue;
                          var category = _categoryValue;
                          
                          //เตรียมข้อมูล
                          Tooyen tooyenList = Tooyen(
                            id:1234,
                            name: name,
                            category :category,
                            date : selectedDate,
                            imgPath : "assets/images/"+category+".png"
                            // date: DateTime.now()
                          );//object

                          //เรียก Provider 
                          var provider = Provider.of<TooyenProvider>(context,listen:false);
                          provider.addTooyen(tooyenList);
                          noti.showNotificationDaily(1234,name, selectedDate);
                          //  manager.showNotificationDaily(tooyenList.id, name, Datetime.now());
                          // provider.delTooyen();
                          Navigator.push(context, MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context){
                              return MyApp();
                          }));
                      } 
                  }, 
                  )),
                ),
                
              ],
            ),
              
              ],
            ),
          )
        
         
        ),
      
            
        
        //     Column(
        //       children: <Widget>[
        //         Text(
        //           'Choose Time',
        //           style: TextStyle(
                    
        //               fontStyle: FontStyle.italic,
        //               fontWeight: FontWeight.w600,
        //               letterSpacing: 0.5),
        //         ),
        //         InkWell(
        //           onTap: () {
        //             _selectTime(context);
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(top: 10),
        //             width: _width / 2,
        //             height: _height / 15,
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(
        //               color: Colors.grey[200],
        //               borderRadius: BorderRadius.circular(29),
        //               ),
                      
        //             child: TextFormField(
        //               style: TextStyle(fontSize: 20),
        //               textAlign: TextAlign.center,
        //               onSaved: (String val) {
        //                 _setTime = val;
        //               },
        //               enabled: false,
        //               keyboardType: TextInputType.text,
        //               controller: _timeController,
        //               decoration: InputDecoration(
        //                   disabledBorder:
        //                       UnderlineInputBorder(borderSide: BorderSide.none),
        //                   // labelText: 'Time',
        //                   contentPadding: EdgeInsets.all(5)),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
       
        
      );
    
  }
}

