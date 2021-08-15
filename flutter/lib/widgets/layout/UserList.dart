import 'package:flutter/material.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/models/User.dart';
import 'package:wastend/widgets/ui/Loading.dart';
import 'package:wastend/widgets/ui/UserWidget.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User>? _users;

  @override
  void initState() {
    super.initState();
    GroupApi.getMembers().then((members){
      setState(() {
        _users = members;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _users == null ? Loading() : Column(
      children: _users!.map((user) => UserWidget(user: user)).toList(),
    );
  }
}
