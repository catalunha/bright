import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/student_action.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/uis/student/student_list_ds.dart';
import 'package:flutter/material.dart';
import 'package:bright/routes.dart';
import 'package:bright/states/app_state.dart';

class ViewModel extends BaseModel<AppState> {
  bool waiting;
  List<StudentModel> studentList;
  Function(String) onEditStudentCurrent;
  Function(String) onMeetList;
  ViewModel();
  ViewModel.build({
    @required this.waiting,
    @required this.studentList,
    @required this.onEditStudentCurrent,
    @required this.onMeetList,
  }) : super(equals: [
          waiting,
          studentList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        waiting: state.wait.isWaiting,
        studentList: state.studentState.studentList,
        onEditStudentCurrent: (String id) {
          dispatch(SetStudentCurrentSyncStudentAction(id));
          dispatch(NavigateAction.pushNamed(Routes.studentEdit));
        },
        onMeetList: (String id) {
          dispatch(SetStudentCurrentSyncStudentAction(id));
          dispatch(NavigateAction.pushNamed(Routes.meetList));
        },
      );
}

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsStudentListAsyncStudentAction()),
      builder: (context, viewModel) => StudentListDS(
        waiting: viewModel.waiting,
        studentList: viewModel.studentList,
        onEditStudentCurrent: viewModel.onEditStudentCurrent,
        onMeetList: viewModel.onMeetList,
      ),
    );
  }
}
