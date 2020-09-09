import 'package:bright/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentSelectDS extends StatelessWidget {
  final List<StudentModel> studentList;
  final Function(String) onCopyCurrentMeetToAnotherStudent;

  const StudentSelectDS({
    Key key,
    this.studentList,
    this.onCopyCurrentMeetToAnotherStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            final student = studentList[index];
            return ListTile(
              title: Text('${student.name}'),
              onTap: () {
                onCopyCurrentMeetToAnotherStudent(student.id);
              },
            );
          },
        ),
      ),
    );
  }
}
