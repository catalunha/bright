import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/meet_action.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/meet/meet_edit_ds.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  String classAct;
  String homeAct;
  int price;
  dynamic start;
  dynamic end;
  bool paid;
  bool isAddOrUpdate;
  Function(String, String, int, dynamic, dynamic) onAdd;
  Function(String, String, int, dynamic, dynamic, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.classAct,
    @required this.homeAct,
    @required this.price,
    @required this.start,
    @required this.end,
    @required this.paid,
    @required this.isAddOrUpdate,
    @required this.onAdd,
    @required this.onUpdate,
  }) : super(equals: [
          classAct,
          homeAct,
          price,
          start,
          end,
          paid,
          isAddOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isAddOrUpdate: state.meetState.meetCurrent.id == null,
        classAct: state.meetState.meetCurrent.classAct,
        homeAct: state.meetState.meetCurrent.homeAct,
        price: state.meetState.meetCurrent.price,
        start: state.meetState.meetCurrent.start,
        end: state.meetState.meetCurrent.end,
        paid: state.meetState.meetCurrent?.paid ?? false,
        onAdd: (
          String classAct,
          String homeAct,
          int price,
          dynamic start,
          dynamic end,
        ) {
          dispatch(AddDocMeetCurrentAsyncMeetAction(
            classAct: classAct,
            homeAct: homeAct,
            price: price,
            start: start,
            end: end,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String classAct, String homeAct, int price, dynamic start,
            dynamic end, bool paid) {
          dispatch(UpdateDocMeetCurrentAsyncMeetAction(
            classAct: classAct,
            homeAct: homeAct,
            price: price,
            start: start,
            end: end,
            paid: paid,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class MeetEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => MeetEditDS(
        isAddOrUpdate: viewModel.isAddOrUpdate,
        classAct: viewModel.classAct,
        homeAct: viewModel.homeAct,
        price: viewModel.price,
        start: viewModel.start,
        end: viewModel.end,
        paid: viewModel.paid,
        onAdd: viewModel.onAdd,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
