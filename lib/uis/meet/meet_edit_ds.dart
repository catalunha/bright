import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MeetEditDS extends StatefulWidget {
  final String classAct;
  final String homeAct;
  final int price;
  final dynamic start;
  final dynamic end;
  final bool paid;
  final bool isAddOrUpdate;
  final Function(String, String, int, dynamic, dynamic) onAdd;
  final Function(String, String, int, dynamic, dynamic, bool) onUpdate;

  const MeetEditDS({
    Key key,
    this.classAct,
    this.homeAct,
    this.price,
    this.start,
    this.end,
    this.paid,
    this.isAddOrUpdate,
    this.onAdd,
    this.onUpdate,
  }) : super(key: key);
  @override
  _MeetEditDSState createState() => _MeetEditDSState();
}

class _MeetEditDSState extends State<MeetEditDS> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String _classAct;
  String _homeAct;
  int _price;
  DateTime _start;
  TimeOfDay _startTime;
  DateTime _end;
  TimeOfDay _endTime;
  bool _paid;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isAddOrUpdate
          ? widget.onAdd(_classAct, _homeAct, _price, _start, _end)
          : widget.onUpdate(_classAct, _homeAct, _price, _start, _end, _paid);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _paid = widget.paid;
    // _price = widget.price ?? 0;
    _start = widget.start != null ? widget.start : DateTime.now();
    _startTime = widget.start != null
        ? TimeOfDay.fromDateTime(widget.start)
        : TimeOfDay.now();

    _end = widget.end != null ? widget.end : DateTime.now();
    _endTime = widget.start != null
        ? TimeOfDay.fromDateTime(widget.end)
        : TimeOfDay.now();
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
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title:
            Text(widget.isAddOrUpdate ? 'Criar encontro' : 'Editar encontro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          bool liberated = true;
          if (liberated) {
            Duration difference = _end.difference(_start);
            if (difference.isNegative) {
              liberated = false;
              showSnackBarHandler(
                  context, 'Data e hora do fim antes do início.');
            } else {
              liberated = true;
            }
          }
          if (liberated) {
            validateData();
          }
        },
      ),
    );
  }

  showSnackBarHandler(context, String msg) {
    scaffoldState.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.classAct,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Atividades em sala',
            ),
            onSaved: (newValue) => _classAct = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.homeAct,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Atividades de casa',
            ),
            onSaved: (newValue) => _homeAct = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.price == null ? '' : widget.price.toString(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Preço do encontro',
            ),
            onSaved: (newValue) => _price = int.parse(newValue),
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          ListTile(
            title: Text('${DateFormat('yyyy-MM-dd HH:mm').format(_start)}'),
            subtitle: Text('Inicio do encontro'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              onStartDate(context)
                  .then((value) => onStartTime(context).then((value) {
                        _start = DateTime(
                          _start.year,
                          _start.month,
                          _start.day,
                          _startTime.hour,
                          _startTime.minute,
                        );
                      }));
            },
          ),
          ListTile(
            title: Text('${DateFormat('yyyy-MM-dd HH:mm').format(_end)}'),
            subtitle: Text('Fim do encontro'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              onEndDate(context)
                  .then((value) => onEndTime(context).then((value) {
                        _end = DateTime(
                          _end.year,
                          _end.month,
                          _end.day,
                          _endTime.hour,
                          _endTime.minute,
                        );
                      }));
            },
          ),
          widget.isAddOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _paid,
                  title:
                      _paid ? Text('Encontro pago') : Text('Encontro não pago'),
                  onChanged: (value) {
                    setState(() {
                      _paid = value;
                    });
                  },
                ),
        ],
      ),
    );
  }
}
