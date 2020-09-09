import 'package:async_redux/async_redux.dart';
import 'package:bright/conectors/meet/meet_edit.dart';
import 'package:bright/conectors/meet/meet_list.dart';
import 'package:bright/conectors/student/student_edit.dart';
import 'package:bright/conectors/student/student_list.dart';
import 'package:flutter/material.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/conectors/welcome.dart';

class Routes {
  static final welcome = '/';
  static final studentList = '/studentList';
  static final studentEdit = '/studentEdit';
  static final meetList = '/meetList';
  static final meetEdit = '/meetEdit';

  static final routes = {
    welcome: (BuildContext context) => UserExceptionDialog<AppState>(
          child: Welcome(),
        ),
    studentList: (BuildContext context) => StudentList(),
    studentEdit: (BuildContext context) => StudentEdit(),
    meetList: (BuildContext context) => MeetList(),
    meetEdit: (BuildContext context) => MeetEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
