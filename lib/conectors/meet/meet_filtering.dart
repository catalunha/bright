import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/meet_action.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/states/types_states.dart';
import 'package:bright/uis/meet/meet_filtering_ds.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ViewModel extends BaseModel<AppState> {
  MeetFilter meetFilter;
  Function(MeetFilter) onSelectFilter;
  ViewModel();
  ViewModel.build({
    @required this.meetFilter,
    @required this.onSelectFilter,
  }) : super(equals: [
          meetFilter,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        meetFilter: state.meetState.meetFilter,
        onSelectFilter: (MeetFilter meetFilter) {
          dispatch(
            SetMeetFilterSyncMeetAction(meetFilter),
          );
        },
      );
}

class MeetFiltering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => MeetFilteringDS(
        meetFilter: viewModel.meetFilter,
        onSelectFilter: viewModel.onSelectFilter,
      ),
    );
  }
}
