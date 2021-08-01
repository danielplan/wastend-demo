import 'package:flutter/material.dart';
import '/widgets/ui/TitleText.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new TitleText(
        title: 'Recipes',
        text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In egestas tellus enim magna pretium');
  }
}
