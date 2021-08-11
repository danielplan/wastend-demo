import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/pages/LoginPage.dart';
import 'package:wastend/widgets/layout/AppWrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget? _currentPage;

  Future<void> checkLoggedIn() async {
    bool isLoggedIn = await AuthApi.isLoggedIn();
    setState(() {
      _currentPage = isLoggedIn ? AppWrapper() : LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLoggedIn();
    return _currentPage ?? new Text('Loading');
  }
}
