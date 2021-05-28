import 'package:meta/meta.dart';

/// {@template todo}
/// Model for a todo. Can contain an optional list of [items] for
/// additional sub-todos.
/// {@endtemplate}
class Todo {
  /// {@macro todo}
  Todo({
    
    @required this.id,
    @required this.date,
    @required this.description,
    this.note,
    this.items,
  });

  /// The id of this todo.
  
  final String id;
  final DateTime date;
  /// The description of this todo.
  final String description;
  final String note;
  /// A list of [Item]s for sub-todos.
  final List<Item> items;

    // Map<String, dynamic> toMap() {
    // return {
    //   'id': id,
    //   'date': date,
    //   'description': description,
    //   'note': note,
    //   'items': items.map((items) => items.toMap()).toList(growable: false)
    // }};

}

/// {@template item}
/// An individual item model, used within a [Todo].
/// {@endtemplate}
class Item {
  /// {@macro item}
  Item({
    @required this.id,
    this.description,
    this.completed = false,
  });

  /// The id of this item.
  final String id;

  /// Description of this item.
  final String description;

  /// Indicates if this item has been completed or not.
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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'description': description,
  //     'completed': completed,
  //   };
  // }

  // static Item fromMap(Map<String, dynamic> map) {
  //   return Item(
  //     id: map['id'],
  //     description: map['description'],
  //     completed: map['completed'],
  //   );
  // }
}
