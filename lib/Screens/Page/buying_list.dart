import 'package:flutter/material.dart';
import 'package:mobile_application/components/text_field_container.dart';
import 'package:mobile_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/components/styles.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/models/models.dart';
import 'package:mobile_application/Screens/hero_dialog_route.dart';

import 'package:mobile_application/add_todo_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application/custom_rect_tween.dart';

import 'package:mobile_application/providers/todo_provider.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';

class BuyingList extends StatefulWidget {
  @override
  _BuyingListState createState() => _BuyingListState();
}

class _BuyingListState extends State<BuyingList> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;


  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? 0 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isDrawerOpen
                        ? GestureDetector(
                            child:
                                Icon(Icons.arrow_back_ios, color: Colors.black),
                            onTap: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : GestureDetector(
                            child: Icon(Icons.menu, color: Colors.black),
                            onTap: () {
                              setState(() {
                                xOffset = 200;
                                yOffset = 80;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      'Buying List',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer(builder: (context, TodoProvider provider, Widget child) {
                var count = provider.todoList.length;
                if (count <= 0) {
                  return Container(
                    height: 640, //ให้กรอบมืดๆมีพื้นที่แสดงเต็มหน้าจอ
                    
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      isDrawerOpen //ทำให้กรอบมืดๆมีมุมโค้งๆ
                                          ? BorderRadius.circular(40)
                                          : BorderRadius.circular(0),

                                  
                                ),
                              ),
                              Center(
                                child: Text(
                                  "ไม่มีรายการที่ต้องซื้อ",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomRight,
                                child: AddTodoButton(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 640, //ให้กรอบมืดๆมีพื้นที่แสดงเต็มหน้าจอ
                    
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      isDrawerOpen //ทำให้กรอบมืดๆมีมุมโค้งๆ
                                          ? BorderRadius.circular(40)
                                          : BorderRadius.circular(0),

                                  
                                ),
                              ),
                              SafeArea(
                                child: _TodoListContent(
                                  todos: provider.todoList,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomRight,
                                child: AddTodoButton(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _TodoListContent extends StatelessWidget {
  const _TodoListContent({
    Key key,
    @required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final _todo = todos[index];
        return _TodoCard(todo: _todo);
      },
    );
  }
}


class _TodoCard extends StatelessWidget {
  /// {@macro todo_card}
  const _TodoCard({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _TodoPopupCard(todo: todo),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        tag: todo.id,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: _TodoTitle(
                            title: todo.description,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.black45,
                              size: 20,
                            ),
                            onPressed: () {
                              var providerTodo = Provider.of<TodoProvider>(
                                context,
                                listen: false);
                                providerTodo.delTodo(todo.id);
                                              
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) {
                                                        return RouteBuying();
                                                      }),);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                
                  if (todo.items != null) ...[
                    const Divider(),
                    Container(
                      child: _TodoItemsBox(items: todo.items),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _TodoTitle extends StatelessWidget {
  
  const _TodoTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}



class _TodoPopupCard extends StatelessWidget {
  const _TodoPopupCard({Key key, this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: todo.id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardColor,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TodoTitle(title: todo.description),
                    const SizedBox(
                      height: 8,
                    ),
                    if (todo.items != null) ...[
                      const Divider(),
                      _TodoItemsBox(items: todo.items),
                    ],
                    
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      
                    ),
                    Text(
                      todo.note
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _TodoItemsBox extends StatelessWidget {
  
  const _TodoItemsBox({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) _TodoItemTile(item: item),
      ],
    );
  }
}


class _TodoItemTile extends StatefulWidget {

  const _TodoItemTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _TodoItemTileState createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<_TodoItemTile> {
  void _onChanged(bool val) {
    setState(() {
      widget.item.completed = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: _onChanged,
        value: widget.item.completed,
      ),
      title: Text(widget.item.description),
    );
  }
}
