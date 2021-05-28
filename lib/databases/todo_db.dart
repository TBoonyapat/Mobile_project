import 'dart:io';
import 'dart:convert';
import 'package:mobile_application/models/models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TodoDB {
  //บริการเกียวกับฐานข้อมูล
  var store = intMapStoreFactory.store("todoList");
  
  String dbName; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  TodoDB({this.dbName});

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> insertData(Todo todoList) async {
    //ฐานข้อมูล => Store
    // transaction.db => expense
    var db = await this.openDatabase();
    // var store = intMapStoreFactory.store("tooyen");
    List<Item> todoItem;
    todoItem = todoList.items;
    String jsonTags = jsonEncode(todoList.items);
                            print(jsonTags);
    // json
    var keyID = store.add(db, {
      "id": todoList.id,
      "date": todoList.date.toIso8601String(),
      "description": todoList.description,
      "note": todoList.note,
      "items" : jsonTags
      // .toIso8601String()
    });
    db.close();
    return keyID;
  }

  Future deleteTodoRec(String id) async{
    var db = await this.openDatabase();
    
    final finder = Finder(filter: Filter.equals("id", id));
    await store.delete(
      await db,
      finder: finder,
    );
  }

  Future deleteAllTodo() async{
    var db = await this.openDatabase();
    // var store = intMapStoreFactory.store("tooyen");
    await store.delete(db);
  }
  //ดึงข้อมูล

  // ใหม่ => เก่า false มาก => น้อย
  // เก่า => ใหม่ true น้อย => มาก
  Future<List<Todo>> loadAllData() async {
    var db = await this.openDatabase();
    
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder('date')]));
    List TodosList = List<Todo>();
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      List<Item> itemList = [];
      // print(record["items"]);
       var decode=jsonDecode(record["items"]);
      itemList = (decode as List).map((data) => new Item.fromJson(data)).toList();
      // itemList = record["items"].map((data) => new Item.fromJson(data)).toList();
      // print(itemList);
      // Item.fromJson(jsonDecode( record["items"]));
      TodosList.add(Todo(
          id:record["id"],
          date : DateTime.parse(record["date"]),
          description: record["description"],
          note: record["note"],
          
          items: itemList,
          ));
    }
    return TodosList;
  }
}
