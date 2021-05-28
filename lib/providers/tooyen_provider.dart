import 'package:flutter/foundation.dart';
import 'package:mobile_application/databases/tooyen_db.dart';
import 'package:mobile_application/models/tooyen.dart';

class TooyenProvider with ChangeNotifier{
    // ตัวอย่างข้อมูล
      List<Tooyen> tooyenList = [];
      List<Tooyen> cateList = [];
      List<Tooyen> findList = [];
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
      
      void initCategory(String cate) async{
          var db=TooyenDB(dbName: "tooyen.db");
          //ดึงข้อมูลมาแสดงผล
          
          cateList=await db.loadCateData(cate.toLowerCase());
          print(cateList);
          notifyListeners();
      }

      void findIngredient(String name) async{
          var db=TooyenDB(dbName: "tooyen.db");
          //ดึงข้อมูลมาแสดงผล
          
          findList=await db.findIng(name.toLowerCase());
          
          notifyListeners();
      }
      
      void addTooyen(Tooyen ingList) async{
          var db=TooyenDB(dbName: "tooyen.db");
          //บันทึกข้อมูล
          await db.insertData(ingList);
          //ดึงข้อมูลมาแสดงผล
          tooyenList=await db.loadAllData();
          //แจ้งเตือน Consumer
          notifyListeners();
      }

       void delTooyen() async{
          var db=TooyenDB(dbName: "tooyen.db");
          
          
          await db.deleteData();
          
      }

      void delIng(int id) async{
          var db=TooyenDB(dbName: "tooyen.db");
          
          
          await db.deleteRec(id);
          
      }
      
}