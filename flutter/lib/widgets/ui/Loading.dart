import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: Theme.of(context).textTheme.bodyText1!.color,
      size: 50.0,
    );
  }
}
