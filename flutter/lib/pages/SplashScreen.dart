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

  @override
  void initState() {
    super.initState();
    getNewPage();
  }

  void onChange() {
      AuthApi.isLoggedIn().then((isLoggedIn) {
        if (isLoggedIn) {
          GroupApi.isInGroup().then((isInGroup)  {
            setState(() {
              _currentPage =
              isInGroup ? AppWrapper(onChange: onChange) : IntroductionPage(
                  onChange: onChange);
            });
          });
        } else {
          setState(() {
            _currentPage = LoginPage(onLogin: onChange,);
          });
        }
    });
  }

  Future<void> getNewPage() async {
    bool isLoggedIn = await AuthApi.isLoggedIn();
    if (isLoggedIn) {
      bool isInGroup = await GroupApi.isInGroup();
      _currentPage = isInGroup ? AppWrapper(onChange: onChange) : IntroductionPage(onChange: onChange);
    } else {
      _currentPage = LoginPage(onLogin: onChange,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentPage ?? new Text('Loading');
  }
}
