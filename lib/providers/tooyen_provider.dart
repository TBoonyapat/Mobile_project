import 'package:flutter/foundation.dart';
import 'package:mobile_application/databases/tooyen_db.dart';
import 'package:mobile_application/models/tooyen.dart';

class TooyenProvider with ChangeNotifier{
    // ตัวอย่างข้อมูล
      List<Tooyen> tooyenList = [];

      // ดึงข้อมูล
      List<Tooyen> getTooyen(){
        return tooyenList;
      }
      void initData() async{
          var db=TooyenDB(dbName: "tooyen.db");
          //ดึงข้อมูลมาแสดงผล
          tooyenList=await db.loadAllData();
          notifyListeners();
      }
      
      void addTooyen(Tooyen ingList) async{
          var db=TooyenDB(dbName: "tooyen.db");
          //บันทึกข้อมูล
          await db.InsertData(ingList);
          //ดึงข้อมูลมาแสดงผล
          tooyenList=await db.loadAllData();
          //แจ้งเตือน Consumer
          notifyListeners();
      }

       void delTooyen() async{
          var db=TooyenDB(dbName: "tooyen.db");
          
          //บันทึกข้อมูล
          await db.DeleteData();
          //ดึงข้อมูลมาแสดงผล
          // tooyenList=await db.loadAllData();
          // //แจ้งเตือน Consumer
          // notifyListeners();
      }

      void delIng(int id) async{
          var db=TooyenDB(dbName: "tooyen.db");
          
          //บันทึกข้อมูล
          await db.deleteRec(id);
          //ดึงข้อมูลมาแสดงผล
          // tooyenList=await db.loadAllData();
          // //แจ้งเตือน Consumer
          // notifyListeners();
      }
      
}