import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportByDateDS extends StatefulWidget {
  final Function(dynamic, dynamic) onReport;

  const ReportByDateDS({
    Key key,
    this.onReport,
  }) : super(key: key);

  @override
  _ReportByDateDSState createState() => _ReportByDateDSState();
}

class _ReportByDateDSState extends State<ReportByDateDS> {
  DateTime _start;
  TimeOfDay _startTime;
  DateTime _end;
  TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _start =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // _startTime = TimeOfDay.now();
    _end =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // _endTime = TimeOfDay.now();
  }

  Future<void> onStartDate(context) async {
    final DateTime showDatePickerStart = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      helpText: 'Data de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
    );
    if (showDatePickerStart != null && showDatePickerStart != _start) {
      setState(() {
        _start = showDatePickerStart;
      });
    }
  }

  Future<void> onStartTime(context) async {
    TimeOfDay showTimePickerStart = await showTimePicker(
      initialTime: _startTime,
      context: context,
      helpText: 'Horário de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (showTimePickerStart != null) {
      setState(() {
        _startTime = showTimePickerStart;
      });
    }
  }

  Future<void> onEndDate(context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _end,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      helpText: 'Data de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
    );
    if (picked != null && picked != _end) {
      setState(() {
        _end = picked;
      });
    }
  }

  Future<void> onEndTime(context) async {
    TimeOfDay showTimePickerEnd = await showTimePicker(
      initialTime: _endTime,
      context: context,
      helpText: 'Horário de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (showTimePickerEnd != null) {
      setState(() {
        _endTime = showTimePickerEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: 300.0,
          width: 400.0,
          child: ListView(
            children: [
              ListTile(
                title: Text('${DateFormat('yyyy-MM-dd 00:00').format(_start)}'),
                subtitle: Text('Inicio do relatório'),
                trailing: Icon(Icons.date_range),
                onTap: () {
                  onStartDate(context).then((value) =>
                      _start = DateTime(_start.year, _start.month, _start.day));
                  // onStartDate(context)
                  //     .then((value) => onStartTime(context).then((value) {
                  //           _start = DateTime(
                  //             _start.year,
                  //             _start.month,
                  //             _start.day,
                  //             _startTime.hour,
                  //             _startTime.minute,
                  //           );
                  //         }));
                },
              ),
              ListTile(
                title: Text('${DateFormat('yyyy-MM-dd 00:00').format(_end)}'),
                subtitle: Text('Fim do relatório'),
                trailing: Icon(Icons.date_range),
                onTap: () {
                  onEndDate(context).then(
                      (value) => DateTime(_end.year, _end.month, _end.day));
                  // onEndDate(context)
                  //     .then((value) => onEndTime(context).then((value) {
                  //           _end = DateTime(
                  //             _end.year,
                  //             _end.month,
                  //             _end.day,
                  //             _endTime.hour,
                  //             _endTime.minute,
                  //           );
                  //         }));
                },
              ),
              ListTile(
                title: Text('Gerar relatório para área de transferência.'),
                trailing: Icon(Icons.copy),
                onTap: () {
                  widget.onReport(_start, _end);
                },
              )
            ],
          )),
    );
  }
}
