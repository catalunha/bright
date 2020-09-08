import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/student_action.dart';
import 'package:bright/routes.dart';
import 'package:bright/states/types_states.dart';
import 'package:flutter/material.dart';
import 'package:bright/models/user_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserModel userModel;
  Function(StudentFilter) onPushStudentListWithFilter;

  ViewModel();
  ViewModel.build({
    @required this.userModel,
    @required this.onPushStudentListWithFilter,
  }) : super(equals: [
          userModel,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
      userModel: state.loggedState.userModelLogged,
      onPushStudentListWithFilter: (StudentFilter studentFilter) {
        dispatch(SetStudentFilterSyncStudentAction(studentFilter));
        dispatch(NavigateAction.pushNamed(Routes.studentList));
      });
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        userModel: viewModel.userModel,
        onPushStudentListWithFilter: viewModel.onPushStudentListWithFilter,
      ),
    );
  }
}
