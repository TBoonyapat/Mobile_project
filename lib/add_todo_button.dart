import 'package:flutter/material.dart';
import 'package:mobile_application/components/styles.dart';
import 'package:uuid/uuid.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';
import 'package:mobile_application/models/models.dart';
import 'package:mobile_application/add_todo_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application/custom_rect_tween.dart';
import 'package:mobile_application/Screens/hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
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

/// Tag-value used for the add todo popup button.
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
  // final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  // List _items;
  // double _fontSize = 14;
  List<Item> _values = [];
  List<Todo> _todo = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  String _TodoEditingController;
  String noteEditingController;

  @override
  void initState() {
    _TodoEditingController = '';
    noteEditingController = '';

    super.initState();
  }

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
    // print(_values.length);
  }

  // _onAdd(id,itemname) {
  //   // setState(() {
  //   //   _values.removeAt();
  //   // });
  // }

  _onPressedModifyTextField() {
    final text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
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
                          hintText: 'New todo',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            _TodoEditingController = value;
                          });
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
                        textStyle: const TextStyle(color: Colors.white),
                        onSubmitted: (outstandingValue) {
                          setState(() {
                            Item itemMap = Item(
                              id: uuid.v4(),
                              description: outstandingValue,
                              completed: false,
                            );

                            _values.add(itemMap);
                            print(_values);
                          });
                        },
                        inputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add items ..',
                        ),
                        onTagChanged: (newValue) {
                          setState(() {
                            Item itemMap = Item(
                              id: uuid.v4(),
                              description: newValue,
                              completed: false,
                            );

                            _values.add(itemMap);
                            print(_values);
                          });
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
                      // This is just a button to illustrate how to use
                      // TextEditingController to set the value
                      // or do whatever you want with it
                      // ElevatedButton(
                      //   onPressed: _onPressedModifyTextField,
                      //   child: const Text('Use Controlelr to Set Value'),
                      // ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Write a note',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      FlatButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            var id = uuid.v4();
                            var name = _TodoEditingController;
                            var note = noteEditingController;
                            var item = _values;

                            Todo todoList = Todo(
                              id: id,
                              description: name,
                              note: note,
                              items: _values,
                            ); //obj

                            //เรียก Provider
                            // var provider = Provider.of<TooyenProvider>(
                            //     context,
                            //     listen: false);
                            // provider.addTooyen(tooyenList);

                            // provider.delTooyen();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       fullscreenDialog: true,
                            //       // builder: (context) {
                            //       //   return RouteHome();
                            //       // }
                            //     ));
                          }
                        },
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
