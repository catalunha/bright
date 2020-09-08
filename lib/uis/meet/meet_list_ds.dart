import 'package:bright/conectors/meet/meet_filtering.dart';
import 'package:bright/models/meet_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:flutter/material.dart';

class MeetListDS extends StatelessWidget {
  final List<MeetModel> meetList;
  final String debt;
  final StudentModel studentCurrent;

  final Function(String) onEditMeetCurrent;

  const MeetListDS({
    Key key,
    this.meetList,
    this.onEditMeetCurrent,
    this.debt,
    this.studentCurrent,
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
            child: Column(
              children: [
                ListTile(
                  selected: meet.paid ?? false,
                  title: Text('${meet.topic}'),
                  subtitle: Text('${meet.toString()}'),
                  onTap: () {
                    onEditMeetCurrent(meet.id);
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
