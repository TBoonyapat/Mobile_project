import 'package:flutter/material.dart';
import 'package:mobile_application/components/styles.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:material_tag_editor/tag_editor.dart';

import 'package:mobile_application/models/models.dart';

import 'package:mobile_application/custom_rect_tween.dart';
import 'package:mobile_application/Screens/hero_dialog_route.dart';
import 'package:provider/provider.dart';
import 'package:mobile_application/providers/todo_provider.dart';

import 'package:mobile_application/Screens/sidebar_layout.dart';


class AddTodoButton extends StatelessWidget {
  
  const AddTodoButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return AddTodo();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


const String _heroAddTodo = 'add-todo-hero';

class AddTodo extends StatefulWidget {
  AddTodo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddTodo createState() => _AddTodo();
}

class _AddTodo extends State<AddTodo> {
  final formKey = GlobalKey<FormState>();

  var uuid = Uuid();
  
  List<Item> _values;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  String _todoEditingController;
  String noteEditingController;

  @override
  void initState() {
    this._todoEditingController = '';
    this.noteEditingController = '';
    _values = [];
 
    
    super.initState();
  }

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
    
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Hero(
            tag: _heroAddTodo,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
            child: Material(
              color: AppColors.accentColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          if (this.mounted) {
                            setState(() {
                              _todoEditingController = value;
                            });
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TagEditor(
                        length: _values.length,
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        delimiters: [',', ' '],
                        hasAddButton: true,
                        resetTextOnSubmitted: true,
                        textStyle: const TextStyle(color: Colors.black),
                        onSubmitted: (outstandingValue) {
                          if(outstandingValue == null || outstandingValue.isEmpty){
                              return ;
                          }
                          else{
                            if (this.mounted) {
                            setState(() {
                            Item itemMap = Item(
                              id: uuid.v4(),
                              description: outstandingValue,
                              completed: false,
                            );

                            _values.add(itemMap);
                            print(_values);
                          });
                          }
                          }
                          
                          
                        },
                        inputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Add items ..',
                        ),
                        onTagChanged: (newValue) {
                          if (this.mounted) {
                            setState(() {
                            Item itemMap = Item(
                              id: uuid.v4(),
                              description: newValue,
                              completed: false,
                            );

                            _values.add(itemMap);
                            print(_values);
                          });
                          }
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: _values[index].description,
                          onDeleted: _onDelete,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Write a note',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                        onChanged: (value) {
                          setState(() {
                              noteEditingController = value;
                            });

                        },
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      FlatButton(
                        onPressed: () {
                           if (_todoEditingController == null ||
                                  _todoEditingController.isEmpty) {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('แจ้งเตือน'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'โปรดกรอกหัวข้อ'),
                                            // Text(
                                            //     'Would you like to approve of this message?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('รับทราบ'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                          if (formKey.currentState.validate()) {
                            var id = uuid.v4();
                            var description = _todoEditingController;
                            var note = noteEditingController;
                            print(note);
                            String jsonTags = jsonEncode(_values);
                            // print(jsonTags);
                            // var item = _values;

                            Todo todoList = Todo(

                              id: id,
                              date: DateTime.now(),
                              description: description,
                              note: note,
                              items: _values,
                            ); //obj

                            //เรียก Provider
                            var providerTodo = Provider.of<TodoProvider>(
                                context,
                                listen: false);
                                print(todoList.description);
                            providerTodo.addTodo(todoList);

                            // provider.delTooyen();
                            
                            Navigator.push(
                                context,
                                
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return RouteBuying();
                                  }
                                ));
                          }
                        }},
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    this.label,
    this.onDeleted,
    this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
