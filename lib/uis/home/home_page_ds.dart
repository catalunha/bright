import 'package:bright/routes.dart';
import 'package:bright/states/types_states.dart';
import 'package:flutter/material.dart';
import 'package:bright/conectors/components/logout_button.dart';
import 'package:bright/models/user_model.dart';

class HomePageDS extends StatelessWidget {
  final UserModel userModel;
  // final Function(StudentFilter) onPushStudentListWithFilter;

  const HomePageDS({
    Key key,
    this.userModel,
    // this.onPushStudentListWithFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá ${userModel?.name}'),
        actions: [
          LogoutButton(),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.people,
            ),
            title: Text('Lista de estudantes'),
            onTap: () => Navigator.pushNamed(context, Routes.studentList),
          ),
        ],
      ),
    );
  }
}
