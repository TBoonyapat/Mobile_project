import 'package:mobile_application/models/models.dart';
import 'package:provider/provider.dart';
import 'package:mobile_application/providers/todo_provider.dart';

/// Fake data used to demo the application.
/// 

final fakeData = [
  Todo(id: 'todo-tag-1', date: DateTime.now(), description: 'Buy', note : '',items: [
    Item(
      id: 'todo-1-item-1',
      description: 'Tuna',
    ),
    Item(
      id: 'todo-1-item-2',
      description: 'Salmon',
    ),
  ]),
  // Todo(id: 'todo-tag-55', description: 'Buying', note : '', items: [
  //   Item(
  //     id: 'todo-1-item-3',
  //     description: 'Crab',
  //   ),
  //   Item(
  //     id: 'todo-1-item-4',
  //     description: 'Kimchi',
  //   ),
  // ]),
  
  
];
