import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/models/User.dart';
import 'package:wastend/pages/group/AddMemberPage.dart';
import 'package:wastend/pages/inventory/CreateInventoryItemPage.dart';
import 'package:wastend/pages/user/EditUserPage.dart';
import '/abstract/themes.dart';
import '/pages/HomePage.dart';
import '/pages/GroupPage.dart';

class AppWrapper extends StatefulWidget {
  final void Function() onChange;

  AppWrapper({required this.onChange});

  @override
  _AppWrapperState createState() => _AppWrapperState(onChange: onChange);

  static PreferredSizeWidget getAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      foregroundColor: Theme.of(context).textTheme.bodyText1!.color,
      actionsIconTheme: Theme.of(context).iconTheme,
      iconTheme: Theme.of(context).iconTheme,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              currentTheme.toggleTheme();
            },
            icon: Icon(Icons.lightbulb))
      ],
    );
  }
}

class _AppWrapperState extends State<AppWrapper> {
  int _currentIndex = 0;
  final void Function() onChange;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    AuthApi.getCurrentUser().then((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  List<Map<String, dynamic>>? tabs;

  _AppWrapperState({required this.onChange}) {
    tabs = [
      {
        'page': HomePage(),
        'icon': Icons.home,
        'text': 'Inventory',
        'addPage': CreateInventoryItemPage()
      },
      {
        'page': GroupPage(onLeave: this.onChange),
        'icon': Icons.group,
        'text': 'Group',
        'addPage': AddMemberPage()
      }
    ];
  }

  Widget _getBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      unselectedItemColor: Theme.of(context).textTheme.bodyText1!.color,
      iconSize: 32.0,
      selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
      selectedItemColor: Theme.of(context).primaryColor,
      items: tabs!
          .map((tab) => BottomNavigationBarItem(
              label: tab['text'], icon: Icon(tab['icon'])))
          .toList(),
      onTap: (index) => {
        this.setState(() {
          _currentIndex = index;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: _getDrawer(context),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25.0),
              child: tabs![_currentIndex]['page'])),
      appBar: AppWrapper.getAppbar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => tabs![_currentIndex]['addPage']))
              .then((result) {
            this.onChange();
          });
        },
        child: Icon(Icons.add, size: 32.0),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: _getBottomNavigationBar(context)),
      ),
    );
  }

  Widget? _getDrawer(BuildContext context) {
    return _currentUser != null
        ? Drawer(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).bottomAppBarColor),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.person,
                            color: CustomTheme.white,
                            size: 48,
                          ),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          child: Text(
                            'Hello ${_currentUser!.displayName}',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: CustomTheme.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '@${_currentUser!.username}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: CustomTheme.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Edit account'),
                    horizontalTitleGap: 5,
                    leading: Icon(Icons.edit,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserPage(user: this._currentUser!))),
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    horizontalTitleGap: 5,
                    leading: Icon(Icons.logout,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    onTap: () {
                      AuthApi.logout().then((value) => this.onChange());
                    },
                  ),
                ],
              ),
            ),
          )
        : null;
  }
}
