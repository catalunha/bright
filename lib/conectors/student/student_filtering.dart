import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/student_action.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/states/types_states.dart';
import 'package:bright/uis/student/student_filtering_ds.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ViewModel extends BaseModel<AppState> {
  StudentFilter studentFilter;
  Function(StudentFilter) onSelectFilter;
  ViewModel();
  ViewModel.build({
    @required this.studentFilter,
    @required this.onSelectFilter,
  }) : super(equals: [
          studentFilter,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        studentFilter: state.studentState.studentFilter,
        onSelectFilter: (StudentFilter studentFilter) {
          dispatch(
            SetStudentFilterSyncStudentAction(studentFilter),
          );
        },
      );
}

class StudentFiltering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) =>
          StudentFilteringDS(
        studentFilter: viewModel.studentFilter,
        onSelectFilter: viewModel.onSelectFilter,
      ),
    );
  }
}
