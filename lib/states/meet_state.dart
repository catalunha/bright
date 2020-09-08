import 'package:bright/models/meet_model.dart';
import 'package:bright/states/types_states.dart';
import 'package:meta/meta.dart';

@immutable
class MeetState {
  final MeetFilter meetFilter;
  final List<MeetModel> meetList;
  final MeetModel meetCurrent;
  MeetState({
    this.meetFilter,
    this.meetList,
    this.meetCurrent,
  });
  factory MeetState.initialState() => MeetState(
        meetFilter: MeetFilter.notpaid,
        meetList: <MeetModel>[],
        meetCurrent: null,
      );
  MeetState copyWith({
    MeetFilter meetFilter,
    List<MeetModel> meetList,
    MeetModel meetCurrent,
  }) =>
      MeetState(
        meetFilter: meetFilter ?? this.meetFilter,
        meetList: meetList ?? this.meetList,
        meetCurrent: meetCurrent ?? this.meetCurrent,
      );
  @override
  int get hashCode =>
      meetFilter.hashCode ^ meetList.hashCode ^ meetCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetState &&
          meetFilter == other.meetFilter &&
          meetList == other.meetList &&
          meetCurrent == other.meetCurrent &&
          runtimeType == other.runtimeType;
}
