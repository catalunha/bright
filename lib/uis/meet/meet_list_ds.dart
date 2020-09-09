import 'package:bright/conectors/meet/meet_filtering.dart';
import 'package:bright/conectors/student/student_select.dart';
import 'package:bright/models/meet_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class MeetListDS extends StatelessWidget {
  final List<MeetModel> meetList;
  final String debt;
  final StudentModel studentCurrent;

  final Function(String) onEditMeetCurrent;
  final Function(String) onSetMeetCurrent;

  const MeetListDS({
    Key key,
    this.meetList,
    this.onEditMeetCurrent,
    this.debt,
    this.studentCurrent,
    this.onSetMeetCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${studentCurrent.name}\nR\$ $debt por ${meetList.length} enc.'),
        actions: [MeetFiltering()],
      ),
      body: ListView.builder(
        itemCount: meetList.length,
        itemBuilder: (context, index) {
          final meet = meetList[index];
          return Card(
            color: meet.paid ? Colors.green[900] : Theme.of(context).cardColor,
            child: Column(
              children: [
                ListTile(
                  // selected: meet.paid ?? false,
                  // trailing: IconButton(
                  //   icon: Icon(Icons.content_paste),
                  //   tooltip: 'Copiar lista em csv. Fazer um CTRL-c.',
                  //   onPressed: () {
                  //     FlutterClipboard.copy(
                  //             'Conteúdo desenvolvido em ${meet.toListString()[1]} com duração de ${meet.toListString()[2]}\n${meet.toListString()[0]}\nInvestimento: ${meet.toListString()[3]}')
                  //         .then((value) {
                  //       print('copied');
                  //       // scaffoldState.currentState.showSnackBar(SnackBar(
                  //       //     content:
                  //       //         Text('Aula copiada para texto. CTRL-c concluído.')));
                  //     });
                  //   },
                  // ),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      onSetMeetCurrent(meet.id);
                      showDialog(
                        context: context,
                        builder: (context) => StudentSelect(),
                      );
                    },
                  ),
                  title: Text('${meet.topic}'),
                  subtitle: Text(
                      'Em ${meet.toListString()[1]} com ${meet.toListString()[2]}\nInvestimento: ${meet.toListString()[3]}'),
                  onTap: () {
                    onEditMeetCurrent(meet.id);
                  },
                  onLongPress: () {
                    FlutterClipboard.copy(
                            'Conteúdo desenvolvido em ${meet.toListString()[1]} com duração de ${meet.toListString()[2]}\n${meet.toListString()[0]}\nInvestimento: ${meet.toListString()[3]}')
                        .then((value) {
                      print('copied');
                      // scaffoldState.currentState.showSnackBar(SnackBar(
                      //     content:
                      //         Text('Aula copiada para texto. CTRL-c concluído.')));
                    });
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
          onEditMeetCurrent(null);
        },
      ),
    );
  }
}
