import 'dart:io';

import 'package:mobile_application/models/tooyen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TooyenDB {
  //บริการเกียวกับฐานข้อมูล
  var store = intMapStoreFactory.store("tooyen");
  
  String dbName; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  TooyenDB({this.dbName});

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
  Future<int> insertData(Tooyen tooyenList) async {
    //ฐานข้อมูล => Store
    
    var db = await this.openDatabase();
    // var store = intMapStoreFactory.store("tooyen");

    // json
    var keyID = store.add(db, {
      "id": tooyenList.id,
      "name": tooyenList.name.toLowerCase(),
      "category": tooyenList.category,
      "date": tooyenList.date.toIso8601String(),
      "imgPath" : tooyenList.imgPath

    });
    db.close();
    return keyID;
  }

  Future deleteRec(int id) async{
    var db = await this.openDatabase();
    
    final finder = Finder(filter: Filter.equals("id", id));
    await store.delete(
      await db,
      finder: finder,
    );
  }

  Future deleteData() async{
    var db = await this.openDatabase();
    // var store = intMapStoreFactory.store("tooyen");
    await store.delete(db);
  }
  //ดึงข้อมูล

  // ใหม่ => เก่า false มาก => น้อย
  // เก่า => ใหม่ true น้อย => มาก
  Future<List<Tooyen>> loadAllData() async {
    var db = await this.openDatabase();
    
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder('date')]));
    List ingredientsList = List<Tooyen>();
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      ingredientsList.add(Tooyen(
          id:record["id"],
          name: record["name"],
          category: record["category"],
          date : DateTime.parse(record["date"]),
          imgPath: record["imgPath"],
          ));
    }
    return ingredientsList;
  }


Future<List<Tooyen>> loadCateData(cate) async {

    var db = await this.openDatabase();
    
    var snapshot = await store.find(db,
        finder: Finder(filter: Filter.equals('category', cate ), 
        sortOrders: [SortOrder('date')]));
    List categoryList = List<Tooyen>();

    for (var record in snapshot) {
    
      categoryList.add(Tooyen(
          id:record["id"],
          name: record["name"],
          category: record["category"],
          date : DateTime.parse(record["date"]),
          imgPath: record["imgPath"],
          ));
    }

    return categoryList;
  }

  Future<List<Tooyen>> findIng(name) async {

    var db = await this.openDatabase();
    
    var snapshot = await store.find(db,
        finder: Finder(filter: Filter.equals('name', name ), 
        sortOrders: [SortOrder('date')]));
    List findList = List<Tooyen>();

    for (var record in snapshot) {
    
      findList.add(Tooyen(
          id:record["id"],
          name: record["name"],
          category: record["category"],
          date : DateTime.parse(record["date"]),
          imgPath: record["imgPath"],
          ));
    }

    return findList;
  }
}