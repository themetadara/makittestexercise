import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/app_blocs.dart';
import '../blocs/app_events.dart';
import '../blocs/app_states.dart';
import '../models/user_model.dart';
import '../repos/repositories.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state){
            if (state is UserLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is UserLoadedState){
              List<UserModel> userList = state.users;
              return CustomScrollView(
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
                          height: 130,
                          padding: EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 11,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(userList[index].avatar),),
                              SizedBox(width: 21),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userList[index].firstname + ' ' + userList[index].lastname,
                                    style: TextStyle(
                                        fontFamily: 'SF_Pro',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    userList[index].email,
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF8A8A8F),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: userList.length,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}