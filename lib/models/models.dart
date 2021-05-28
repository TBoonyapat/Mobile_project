import 'package:meta/meta.dart';


class Todo {
  
  Todo({
    
    @required this.id,
    @required this.date,
    @required this.description,
    this.note,
    this.items,
  });

 
  final String id;
  final DateTime date;
  
  final String description;
  final String note;
  
  final List<Item> items;

    
}


class Item {

  Item({
    @required this.id,
    this.description,
    this.completed = false,
  });

  
  final String id;
  final String description;

  
  bool completed;

  Map toJson() => {
        'id': id,
        'description': description,
        'completed': completed
      };

    factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json['id'] as String, description :json['description'] as String, completed : json['completed'] as bool);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.description}, ${this.completed} }';
  }

  
}
