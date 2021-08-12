import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/pages/IntroductionPage.dart';
import 'package:wastend/pages/LoginPage.dart';
import 'package:wastend/widgets/layout/AppWrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget? _currentPage;

  Future<void> getNewPage() async {
    Widget newPage = LoginPage();
    bool isLoggedIn = await AuthApi.isLoggedIn();
    if(isLoggedIn) {
      bool isInGroup = await GroupApi.isInGroup();
      newPage = isInGroup ? AppWrapper() : IntroductionPage();
    }
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    getNewPage();
    return _currentPage ?? new Text('Loading');
  }
}
