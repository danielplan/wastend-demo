import 'package:flutter/material.dart';
import 'package:wastend/pages/inventory/CreateInventoryItemPage.dart';
import '/widgets/layout/CustomAppBar.dart';
import '/abstract/themes.dart';
import '/pages/HomePage.dart';
import '/pages/ListPage.dart';
import '/pages/RecipesPage.dart';
import '/pages/MembersPage.dart';

class AppWrapper extends StatefulWidget {
  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> tabs = [
    {
      'page': HomePage(),
      'icon': Icons.home,
      'text': 'Inventory',
      'addPage': CreateInventoryItemPage()
    },
    {'page': ListPage(), 'icon': Icons.checklist, 'text': 'List'},
    {'page': RecipesPage(), 'icon': Icons.restaurant_menu, 'text': 'Recipes'},
    {'page': MembersPage(), 'icon': Icons.group, 'text': 'Members'}
  ];

  Widget getCustomNavigationBar(BuildContext context) {
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
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
              child: tabs[_currentIndex]['page'])),
      appBar: CustomAppBar(
          text: tabs[_currentIndex]['text'], icon: tabs[_currentIndex]['icon']),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => tabs[_currentIndex]['addPage']))
              .then((result) {

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
            child: getCustomNavigationBar(context)),
      ),
    );
  }
}
