import 'package:flutter/foundation.dart';
import 'package:mobile_application/databases/todo_db.dart';
import 'package:mobile_application/models/models.dart';

class TodoProvider with ChangeNotifier{
    // ตัวอย่างข้อมูล
      List<Todo> todoList = [];

      // ดึงข้อมูล
      List<Todo> getTodo(){
        return todoList;
      }
      void initData() async{
          var db=TodoDB(dbName: "todoList.db");
          //ดึงข้อมูลมาแสดงผล
          todoList=await db.loadAllData();
          notifyListeners();
      }
      
      void addTodo(Todo ingList) async{
          var db=TodoDB(dbName: "todoList.db");
          //บันทึกข้อมูล
          await db.insertData(ingList);
          //ดึงข้อมูลมาแสดงผล
          todoList=await db.loadAllData();
          //แจ้งเตือน Consumer
          notifyListeners();
      }

       void delTodoAll() async{
          var db=TodoDB(dbName: "todoList.db");
          
          //บันทึกข้อมูล
          await db.deleteAllTodo();
          //ดึงข้อมูลมาแสดงผล
          // tooyenList=await db.loadAllData();
          // //แจ้งเตือน Consumer
          // notifyListeners();
      }

      void delTodo(String id) async{
          var db=TodoDB(dbName: "todoList.db");
          
          //บันทึกข้อมูล
          await db.deleteTodoRec(id);
          //ดึงข้อมูลมาแสดงผล
          // tooyenList=await db.loadAllData();
          // //แจ้งเตือน Consumer
          // notifyListeners();
      }
      
}