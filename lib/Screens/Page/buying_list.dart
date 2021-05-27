// import 'package:flutter/material.dart';
// import 'package:mobile_application/components/text_field_container.dart';
// import 'package:mobile_application/constants.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mobile_application/noti/notification_service.dart';
// import 'package:mobile_application/providers/tooyen_provider.dart';
// import 'package:mobile_application/components/styles.dart';
// import 'package:mobile_application/models/tooyen.dart';
// import 'package:mobile_application/models/models.dart';
// import 'package:mobile_application/Screens/sidebar_layout.dart';
// import 'package:mobile_application/Screens/hero_dialog_route.dart';
// import 'package:mobile_application/fake_data.dart';
// import 'package:mobile_application/add_todo_button.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_application/custom_rect_tween.dart';
// import 'dart:math';

// class BuyingList extends StatefulWidget {
//   @override
//   _BuyingListState createState() => _BuyingListState();
// }

// class _BuyingListState extends State<BuyingList> {
//   double xOffset = 0;
//   double yOffset = 0;
//   bool isDrawerOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedContainer(
//         transform: Matrix4.translationValues(xOffset, yOffset, 0)
//           ..scale(isDrawerOpen ? 0.85 : 1.00)
//           ..rotateZ(isDrawerOpen ? 0 : 0),
//         duration: Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           //color: Color(0xFFA0C2A5),
//           borderRadius: isDrawerOpen
//               ? BorderRadius.circular(40)
//               : BorderRadius.circular(0),
//         ),
//         child: ListView(children: [
//           Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     isDrawerOpen
//                         ? GestureDetector(
//                             child:
//                                 Icon(Icons.arrow_back_ios, color: Colors.black),
//                             onTap: () {
//                               setState(() {
//                                 xOffset = 0;
//                                 yOffset = 0;
//                                 isDrawerOpen = false;
//                               });
//                             },
//                           )
//                         : GestureDetector(
//                             child: Icon(
//                               Icons.menu,
//                               color: Colors.black,
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 xOffset = 200;
//                                 yOffset = 80;
//                                 isDrawerOpen = true;
//                               });
//                             },
//                           ),
//                     Text(
//                       'Buying List',
//                       style: GoogleFonts.raleway(
//                         textStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                             decoration: TextDecoration.none),
//                       ),
//                     ),
//                     GestureDetector(
//                       child: Container(
//                         height: 220,
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               //กรอบ1(สีเทา)
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFA0C2A5),
//                                       // color: Colors.blueGrey[300],
//                                       borderRadius: BorderRadius.circular(20),
//                                       // boxShadow: shadowList,
//                                     ),
//                                     margin: EdgeInsets.only(top: 50),
//                                   ),
//                                   Align(
//                                     child: Hero(
//                                         tag: 1,
//                                         child: Image.asset(
//                                             'assets/images/monkey.png')),
//                                     //child: Image.asset('assets/images/monkey.png')),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               //กรอบ2(สีขาว)
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 60, bottom: 20),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         // boxShadow: shadowList,
//                                         borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(20),
//                                             bottomRight: Radius.circular(20))),
//                                   ),
//                                   // Align(
//                                   //   child: Text('ผัก'),
//                                   // ),
//                                   Align(
//                                     //ทำให้อยู่ในช่องที่สร้างข้างบน
//                                     alignment: Alignment(1.50, 0.75),
//                                     child: FlatButton(
//                                         child: Icon(
//                                           Icons.delete,
//                                           color: Colors.red[900],
//                                           size: 30,
//                                         ),
//                                         onPressed: () => null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Expanded(
//                             //     child: Stack(
//                             //   children: <Widget>[
//                             //     new LinearPercentIndicator(
//                             //       width: 100.0,
//                             //       lineHeight: 8.0,
//                             //       percent: 0.2,
//                             //       progressColor: Colors.red,
//                             //     ),
//                             //   ],
//                             // )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       AppColors.backgroundFadedColor,
//                       //
//                     ],
//                     stops: [0.0, 1],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_application/components/text_field_container.dart';
import 'package:mobile_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application/noti/notification_service.dart';
import 'package:mobile_application/providers/tooyen_provider.dart';
import 'package:mobile_application/components/styles.dart';
import 'package:mobile_application/models/tooyen.dart';
import 'package:mobile_application/models/models.dart';
import 'package:mobile_application/Screens/sidebar_layout.dart';
import 'package:mobile_application/Screens/hero_dialog_route.dart';
import 'package:mobile_application/fake_data.dart';
import 'package:mobile_application/add_todo_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application/custom_rect_tween.dart';
import 'dart:math';
import 'package:mobile_application/components/configuration.dart';

class BuyingList extends StatefulWidget {
  @override
  _BuyingListState createState() => _BuyingListState();
}

class _BuyingListState extends State<BuyingList> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

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
              Container(
                height: 640, //ให้กรอบมืดๆมีพื้นที่แสดงเต็มหน้าจอ
                //margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: isDrawerOpen //ทำให้กรอบมืดๆมีมุมโค้งๆ
                                  ? BorderRadius.circular(40)
                                  : BorderRadius.circular(0),

                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.backgroundFadedColor,
                                  AppColors.backgroundColor,
                                ],
                                stops: [0.0, 1],
                              ),
                            ),
                          ),
                          SafeArea(
                            child: _TodoListContent(
                              todos: fakeData,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, TooyenProvider provider, Widget child) {
        var count = provider.tooyenList.length; //นับจำนวนข้อมูล
        if (count <= 0) {
          return Center(
            child: Text(
              "ไม่พบข้อมูล",
              style: TextStyle(fontSize: 35),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                Tooyen data = provider.tooyenList[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(data.category),
                      ),
                    ),
                    title: Text(data.name),
                    subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                  ),
                );
              });
        }
      },
    ));
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

/// {@template todo_card}
/// Card that display a [Todo]'s content.
///
/// On tap it opens a [HeroDialogRoute] with [_TodoPopupCard] as the content.
/// {@endtemplate}
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _TodoTitle(title: todo.description),
                  const SizedBox(
                    height: 8,
                  ),
                  if (todo.items != null) ...[
                    const Divider(),
                    _TodoItemsBox(items: todo.items),
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

/// {@template todo_title}
/// Title of a [Todo].
/// {@endtemplate}
class _TodoTitle extends StatelessWidget {
  /// {@macro todo_title}
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

/// {@template todo_popup_card}
/// Popup card to expand the content of a [Todo] card.
///
/// Activated from [_TodoCard].
/// {@endtemplate}
///

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
                      child: const TextField(
                        maxLines: 8,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Write a note...',
                            border: InputBorder.none),
                      ),
                    ),
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

/// {@template todo_items_box}
/// Box containing the list of a [Todo]'s items.
///
/// These items can be checked.
/// {@endtemplate}
class _TodoItemsBox extends StatelessWidget {
  /// {@macro todo_items_box}
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

/// {@template todo_item_template}
/// An individual [Todo] [Item] with its [Checkbox].
/// {@endtemplate}
class _TodoItemTile extends StatefulWidget {
  /// {@macro todo_item_template}
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
