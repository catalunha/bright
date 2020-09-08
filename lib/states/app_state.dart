import 'package:async_redux/async_redux.dart';
import 'package:bright/states/logged_state.dart';
import 'package:bright/states/meet_state.dart';
import 'package:bright/states/student_state.dart';
import 'package:bright/states/user_state.dart';

class AppState {
  final Wait wait;
  final LoggedState loggedState;
  final UserState userState;
  final StudentState studentState;
  final MeetState meetState;

  AppState({
    this.wait,
    this.loggedState,
    this.userState,
    this.studentState,
    this.meetState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        studentState: StudentState.initialState(),
        meetState: MeetState.initialState(),
      );
  AppState copyWith({
    Wait wait,
    LoggedState loggedState,
    UserState userState,
    StudentState studentState,
    MeetState meetState,
  }) =>
      AppState(
        wait: wait ?? this.wait,
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        studentState: studentState ?? this.studentState,
        meetState: meetState ?? this.meetState,
      );
  @override
  int get hashCode =>
      meetState.hashCode ^
      studentState.hashCode ^
      loggedState.hashCode ^
      userState.hashCode ^
      wait.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          meetState == other.meetState &&
          studentState == other.studentState &&
          userState == other.userState &&
          loggedState == other.loggedState &&
          wait == other.wait &&
          runtimeType == other.runtimeType;
}
