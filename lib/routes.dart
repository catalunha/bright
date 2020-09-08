import 'package:async_redux/async_redux.dart';
import 'package:bright/conectors/student/student_edit.dart';
import 'package:bright/conectors/student/student_list.dart';
import 'package:flutter/material.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/conectors/welcome.dart';

class Routes {
  static final home = '/';
  static final studentList = '/studentList';
  static final studentEdit = '/studentEdit';

  static final routes = {
    home: (BuildContext context) => UserExceptionDialog<AppState>(
          child: Welcome(),
        ),
    studentList: (BuildContext context) => StudentList(),
    studentEdit: (BuildContext context) => StudentEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
