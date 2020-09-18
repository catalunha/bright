import 'package:bright/conectors/components/logout_button.dart';
import 'package:bright/conectors/report/report_bydate.dart';
import 'package:bright/conectors/student/student_filtering.dart';
import 'package:bright/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentListDS extends StatelessWidget {
  final bool waiting;
  final List<StudentModel> studentList;
  final Function(String) onEditStudentCurrent;
  final Function(String) onMeetList;

  const StudentListDS({
    Key key,
    this.studentList,
    this.onEditStudentCurrent,
    this.onMeetList,
    this.waiting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Estudantes (${studentList.length})'),
            actions: [
              StudentFiltering(),
              IconButton(
                tooltip: 'Gerar relatório.',
                icon: Icon(Icons.date_range),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ReportByDate(),
                  );
                },
              ),
              LogoutButton(),
            ],
          ),
          body: ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              return Card(
                color: !student.active
                    ? Colors.brown
                    : Theme.of(context).cardColor,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 500,
                      child: ListTile(
                        // selected: !student.active ?? false,
                        title: Text('${student.name}'),
                        subtitle: Text('${student.toString()}'),
                        onTap: () {
                          onMeetList(student.id);
                        },
                        // trailing: IconButton(
                        //   icon: Icon(Icons.edit),
                        //   onPressed: () async {
                        //     onEditStudentCurrent(student.id);
                        //   },
                        // ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        onEditStudentCurrent(student.id);
                      },
                    ),
                    IconButton(
                      tooltip: 'Programa do aluno',
                      icon: Icon(MdiIcons.fileLink),
                      onPressed: () async {
                        if (student?.urlProgram != null) {
                          if (await canLaunch(student.urlProgram)) {
                            await launch(student.urlProgram);
                          }
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Meu diário sobre o aluno',
                      icon: Icon(MdiIcons.fileLinkOutline),
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
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              onEditStudentCurrent(null);
            },
          ),
        ),
        if (waiting)
          Material(
            child: Stack(
              children: [
                Center(child: CircularProgressIndicator()),
                Center(
                  child: Text(
                    'Gerando relatório ...',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ModalBarrier(
                  color: Colors.green.withOpacity(0.4),
                ),
              ],
            ),
          )
      ],
    );
  }
}
