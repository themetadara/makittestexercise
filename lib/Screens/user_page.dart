import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  ScrollController _scrollController = ScrollController();
  bool _isTitleCentered = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    readJson();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isTitleCentered) {
      setState(() {
        _isTitleCentered = true;
      });
    } else if (_scrollController.offset <= 0 && _isTitleCentered) {
      setState(() {
        _isTitleCentered = false;
      });
    }
  }

  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["users"];
      print("number of items ${_items.length}");
    });
  }

  bool jsonChecking(){
    readJson();
    if(_items.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _items.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: _isTitleCentered,
                      collapseMode: CollapseMode.parallax,
                      titlePadding: EdgeInsets.only(
                        left: 16,
                        bottom: 16,
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Пользователи',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SF_Pro',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          height: 80,
                          padding: EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 11,
                          ),
                          child: Row(
                            children: [
                              Image.asset('images/user-circle.png',
                                  fit: BoxFit.fill),
                              SizedBox(width: 21),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _items[index]["name"],
                                    style: TextStyle(
                                        fontFamily: 'SF_Pro',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    _items[index]["email"],
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF8A8A8F),
                                    ),
                                  ),
                                  Text(
                                    _items[index]["username"],
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: _items.length,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/warning-sign 1.png'),
                  SizedBox(
                    height: 32,
                  ),
                  Text('Не удалось загрузить информацию',style: TextStyle(
                    fontFamily: 'SF_Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      jsonChecking();
                    },
                    child: Text('Обновить'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9B51E0),
                      fixedSize: Size(230, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
