import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/models/User.dart';
import 'package:wastend/pages/group/AddMemberPage.dart';
import 'package:wastend/pages/inventory/CreateInventoryItemPage.dart';
import '/widgets/layout/CustomAppBar.dart';
import '/abstract/themes.dart';
import '/pages/HomePage.dart';
import '/pages/GroupPage.dart';

class AppWrapper extends StatefulWidget {
  final void Function() onChange;

  AppWrapper({required this.onChange});

  @override
  _AppWrapperState createState() => _AppWrapperState(onChange: onChange);
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

  _AppWrapperState({required this.onChange});

  final List<Map<String, dynamic>> tabs = [
    {
      'page': HomePage(),
      'icon': Icons.home,
      'text': 'Inventory',
      'addPage': CreateInventoryItemPage()
    },
    {
      'page': GroupPage(),
      'icon': Icons.group,
      'text': 'Group',
      'addPage': AddMemberPage()
    }
  ];

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
      items: tabs
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
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
              child: tabs[_currentIndex]['page'])),
      appBar: CustomAppBar(
        text: tabs[_currentIndex]['text'],
        icon: tabs[_currentIndex]['icon'],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => tabs[_currentIndex]['addPage']))
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
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0), bottom: Radius.zero),
            boxShadow: [
              BoxShadow(
                  color: CustomTheme.dark.withOpacity(0.05), blurRadius: 25.0)
            ]),
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
                        Text(
                          'Hello ${_currentUser!.displayName}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: CustomTheme.white),
                        ),
                        Text(
                          '@${_currentUser!.username}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: CustomTheme.white),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Change theme'),
                    horizontalTitleGap: 5,
                    leading: Icon(Icons.light,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    onTap: () {
                      currentTheme.toggleTheme();
                    },
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
