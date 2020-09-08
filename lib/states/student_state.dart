import 'package:bright/models/student_model.dart';
import 'package:meta/meta.dart';

@immutable
class StudentState {
  final List<StudentModel> studentList;
  final StudentModel studentCurrent;
  StudentState({
    this.studentList,
    this.studentCurrent,
  });
  factory StudentState.initialState() => StudentState(
        studentList: <StudentModel>[],
        studentCurrent: null,
      );
  StudentState copyWith({
    List<StudentModel> studentList,
    StudentModel studentCurrent,
  }) =>
      StudentState(
        studentList: studentList ?? this.studentList,
        studentCurrent: studentCurrent ?? this.studentCurrent,
      );
  @override
  int get hashCode => studentList.hashCode ^ studentCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentState &&
          studentList == other.studentList &&
          studentCurrent == other.studentCurrent &&
          runtimeType == other.runtimeType;
}
