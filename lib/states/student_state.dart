import 'package:bright/models/student_model.dart';
import 'package:bright/states/types_states.dart';
import 'package:meta/meta.dart';

@immutable
class StudentState {
  final StudentFilter studentFilter;
  final List<StudentModel> studentList;
  final StudentModel studentCurrent;
  StudentState({
    this.studentFilter,
    this.studentList,
    this.studentCurrent,
  });
  factory StudentState.initialState() => StudentState(
        studentFilter: StudentFilter.active,
        studentList: <StudentModel>[],
        studentCurrent: null,
      );
  StudentState copyWith({
    StudentFilter studentFilter,
    List<StudentModel> studentList,
    StudentModel studentCurrent,
  }) =>
      StudentState(
        studentFilter: studentFilter ?? this.studentFilter,
        studentList: studentList ?? this.studentList,
        studentCurrent: studentCurrent ?? this.studentCurrent,
      );
  @override
  int get hashCode =>
      studentFilter.hashCode ^ studentList.hashCode ^ studentCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentState &&
          studentFilter == other.studentFilter &&
          studentList == other.studentList &&
          studentCurrent == other.studentCurrent &&
          runtimeType == other.runtimeType;
}
