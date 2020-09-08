import 'package:bright/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentListDS extends StatelessWidget {
  final List<StudentModel> studentList;
  final Function(String) onEditStudentCurrent;

  const StudentListDS({
    Key key,
    this.studentList,
    this.onEditStudentCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de estudantes (${studentList.length})'),
      ),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          final student = studentList[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  selected: !student.active ?? false,
                  title: Text('${student.name}'),
                  subtitle: Text('${student.toString()}'),
                  onTap: () {
                    onEditStudentCurrent(student.id);
                  },
                ),
                Wrap(
                  children: [
                    IconButton(
                      icon: Icon(Icons.ac_unit),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditStudentCurrent(null);
        },
      ),
    );
  }
}
