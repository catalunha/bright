import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:bright/actions/logged_action.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/components/logout_button_ds.dart';

class ViewModel extends BaseModel<AppState> {
  void Function() logout;

  ViewModel();
  ViewModel.build({
    @required this.logout,
  }) : super(equals: []);
  @override
  ViewModel fromStore() => ViewModel.build(logout: () {
        return dispatch(LogoutAsyncLoggedAction());
      });
}

class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return LogoutButtonDS(
          logout: vm.logout,
        );
      },
    );
  }
}
