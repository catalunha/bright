import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/meet_action.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/student/student_select_ds.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  List<StudentModel> studentList;
  Function(String) onCopyCurrentMeetToAnotherStudent;
  ViewModel();
  ViewModel.build({
    @required this.studentList,
    @required this.onCopyCurrentMeetToAnotherStudent,
  }) : super(equals: [
          studentList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        studentList: state.studentState.studentList,
        onCopyCurrentMeetToAnotherStudent: (String studentId) {
          if (studentId != null) {
            dispatch(CopyCurrentMeetToAnotherStudentSyncMeetAction(studentId));
          }
          dispatch(NavigateAction.pop());
        },
      );
}

class StudentSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => StudentSelectDS(
        studentList: viewModel.studentList,
        onCopyCurrentMeetToAnotherStudent:
            viewModel.onCopyCurrentMeetToAnotherStudent,
      ),
    );
  }
}
