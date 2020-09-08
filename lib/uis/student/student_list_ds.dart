import 'package:bright/conectors/student/student_filtering.dart';
import 'package:bright/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentListDS extends StatelessWidget {
  final List<StudentModel> studentList;
  final Function(String) onEditStudentCurrent;
  final Function(String) onEditMeet;

  const StudentListDS({
    Key key,
    this.studentList,
    this.onEditStudentCurrent,
    this.onEditMeet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudantes (${studentList.length})'),
        actions: [StudentFiltering()],
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
                    onEditMeet(student.id);
                  },
                ),
                Wrap(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        onEditStudentCurrent(student.id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () async {
                        if (student?.urlProgram != null) {
                          if (await canLaunch(student.urlProgram)) {
                            await launch(student.urlProgram);
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () async {
                        if (student?.urlDiary != null) {
                          if (await canLaunch(student.urlDiary)) {
                            await launch(student.urlDiary);
                          }
                        }
                      },
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
