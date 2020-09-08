import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/meet_action.dart';
import 'package:bright/models/meet_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/uis/meet/meet_list_ds.dart';
import 'package:flutter/material.dart';
import 'package:bright/routes.dart';
import 'package:bright/states/app_state.dart';

class ViewModel extends BaseModel<AppState> {
  List<MeetModel> meetList;
  StudentModel studentCurrent;
  String debt;
  Function(String) onEditMeetCurrent;
  ViewModel();
  ViewModel.build({
    @required this.meetList,
    @required this.debt,
    @required this.studentCurrent,
    @required this.onEditMeetCurrent,
  }) : super(equals: [
          meetList,
          debt,
          studentCurrent,
        ]);
  String _debt() {
    List<MeetModel> _meetList = state.meetState.meetList;
    int _debt = 0;
    _meetList.forEach((element) {
      _debt = _debt + element.price ?? 0;
    });
    return (_debt / 100).toStringAsFixed(2);
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        meetList: state.meetState.meetList,
        debt: _debt(),
        studentCurrent: state.studentState.studentCurrent,
        onEditMeetCurrent: (String id) {
          dispatch(SetMeetCurrentSyncMeetAction(id));
          dispatch(NavigateAction.pushNamed(Routes.meetEdit));
        },
      );
}

class MeetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsMeetListAsyncMeetAction()),
      builder: (context, viewModel) => MeetListDS(
        meetList: viewModel.meetList,
        debt: viewModel.debt,
        studentCurrent: viewModel.studentCurrent,
        onEditMeetCurrent: viewModel.onEditMeetCurrent,
      ),
    );
  }
}
