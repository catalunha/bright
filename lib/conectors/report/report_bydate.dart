import 'package:async_redux/async_redux.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/report/report_bydate_ds.dart';
import 'package:flutter/material.dart';
import 'package:bright/actions/student_action.dart';

class ViewModel extends BaseModel<AppState> {
  Function(dynamic, dynamic) onReport;
  ViewModel();
  ViewModel.build({
    @required this.onReport,
  }) : super(equals: []);
  @override
  ViewModel fromStore() =>
      ViewModel.build(onReport: (dynamic start, dynamic end) {
        dispatch(ReportAsyncStudentAction(start: start, end: end));
        dispatch(NavigateAction.pop());
      });
}

class ReportByDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => ReportByDateDS(
        onReport: viewModel.onReport,
      ),
    );
  }
}
