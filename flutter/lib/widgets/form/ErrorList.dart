import 'package:flutter/material.dart';
import 'package:wastend/widgets/ui/Callout.dart';

class ErrorList extends StatelessWidget {

  final List<String> errors;

  ErrorList({required this.errors});

  @override
  Widget build(BuildContext context) {
    return Column(children: errors
            .map((error) => new Callout(calloutText: error))
            .toList()
    );
  }
}
