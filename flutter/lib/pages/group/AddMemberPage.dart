import 'package:flutter/material.dart';
import 'package:wastend/widgets/form/AddMemberForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import 'package:wastend/widgets/ui/TitleText.dart';

class AddMemberPage extends StatelessWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        name: 'Add group member',
        icon: Icons.group_add,
        body: Column(
          children: [
            TitleText(
                title: 'Add a group member',
                text: 'Just give the name add the member'),
            AddMemberForm()
          ],
        ));
  }
}
