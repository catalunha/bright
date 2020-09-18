import 'package:bright/conectors/meet/meet_filtering.dart';
import 'package:bright/conectors/student/student_select.dart';
import 'package:bright/models/meet_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/uis/icons/my_flutter_app_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Container(
                  width: 500,
                  child: ListTile(
                    // trailing: IconButton(
                    //   icon: Icon(Icons.copy),
                    //   onPressed: () {
                    //     onSetMeetCurrent(meet.id);
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => StudentSelect(),
                    //     );
                    //   },
                    // ),
                    title: Text(
                        '${meet.labelTo("start")} com ${meet.labelTo("betweenStartToEnd")}\nInvestimento: ${meet.labelTo("price")}'),
                    subtitle: Text(
                        'Atividades em sala:\n${meet.classAct}\nAtividades para casa:\n${meet.homeAct}'),
                    // onTap: () {
                    //   onEditMeetCurrent(meet.id);
                    // },
                    // onLongPress: () {
                    //   String _copy = '';
                    //   _copy = _copy +
                    //       'Encontro de ${meet.labelTo("start")} com duração de ${meet.labelTo("betweenStartToEnd")}';
                    //   _copy =
                    //       _copy + '\nInvestimento: ${meet.labelTo("price")}';
                    //   _copy = _copy + '\nAtividades em sala:\n${meet.classAct}';
                    //   _copy =
                    //       _copy + '\nAtividades para casa:\n${meet.homeAct}';
                    //   FlutterClipboard.copy(_copy).then((value) {
                    //     print('copied');
                    //     // scaffoldState.currentState.showSnackBar(SnackBar(
                    //     //     content:
                    //     //         Text('Aula copiada para texto. CTRL-c concluído.')));
                    //   });
                    // },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  // icon: Icon(MyFlutterApp.access_time),
                  onPressed: () {
                    onEditMeetCurrent(meet.id);
                  },
                ),
                IconButton(
                  tooltip: 'Cópia longa',
                  icon: Icon(MdiIcons.clipboardTextMultiple),
                  // https://materialdesignicons.com/
                  onPressed: () {
                    String _copy = '';
                    _copy = _copy +
                        'Encontro de ${meet.labelTo("start")} com duração de ${meet.labelTo("betweenStartToEnd")}';
                    _copy = _copy + '\nInvestimento: ${meet.labelTo("price")}';
                    _copy = _copy + '\nAtividades em sala:\n${meet.classAct}';
                    _copy = _copy + '\nAtividades para casa:\n${meet.homeAct}';
                    FlutterClipboard.copy(_copy).then((value) {
                      print('copied');
                      // scaffoldState.currentState.showSnackBar(SnackBar(
                      //     content:
                      //         Text('Aula copiada para texto. CTRL-c concluído.')));
                    });
                  },
                ),
                IconButton(
                  tooltip: 'Cópia resumida',
                  // icon: Icon(MyFlutterApp.access_time),
                  icon: Icon(MdiIcons.clipboardTextMultipleOutline),
                  onPressed: () {
                    String _copy = '';
                    _copy = _copy +
                        'Encontro de ${meet.labelTo("start")} com duração de ${meet.labelTo("betweenStartToEnd")}';
                    _copy = _copy + '\nInvestimento: ${meet.labelTo("price")}';
                    FlutterClipboard.copy(_copy).then((value) {
                      print('copied');
                      // scaffoldState.currentState.showSnackBar(SnackBar(
                      //     content:
                      //         Text('Aula copiada para texto. CTRL-c concluído.')));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(MdiIcons.accountPlus),
                  onPressed: () {
                    onSetMeetCurrent(meet.id);
                    showDialog(
                      context: context,
                      builder: (context) => StudentSelect(),
                    );
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
