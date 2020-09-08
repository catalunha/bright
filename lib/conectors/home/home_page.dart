import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:bright/models/user_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserModel userModel;
  ViewModel();
  ViewModel.build({
    @required this.userModel,
  }) : super(equals: [
          userModel,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
        userModel: state.loggedState.userModelLogged,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        userModel: viewModel.userModel,
      ),
    );
  }
}
