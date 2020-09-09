import 'package:flutter/material.dart';

class StudentEditDS extends StatefulWidget {
  final String code;
  final String name;
  final String email;
  final String phone;
  final String urlProgram;
  final String urlDiary;
  final String group;
  final String description;
  final bool active;
  final bool isAddOrUpdate;
  final Function(String, String, String, String, String, String, String, String)
      onAdd;
  final Function(
          String, String, String, String, String, String, String, String, bool)
      onUpdate;

  const StudentEditDS({
    Key key,
    this.code,
    this.description,
    this.isAddOrUpdate,
    this.onAdd,
    this.onUpdate,
    this.name,
    this.email,
    this.phone,
    this.urlProgram,
    this.urlDiary,
    this.active,
    this.group,
  }) : super(key: key);
  @override
  _StudentEditDSState createState() => _StudentEditDSState();
}

class _StudentEditDSState extends State<StudentEditDS> {
  final formKey = GlobalKey<FormState>();
  String _code;
  String _name;
  String _email;
  String _phone;
  String _urlProgram;
  String _urlDiary;
  String _group;
  String _description;
  bool _active;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isAddOrUpdate
          ? widget.onAdd(_code, _name, _email, _phone, _urlProgram, _urlDiary,
              _group, _description)
          : widget.onUpdate(_code, _name, _email, _phone, _urlProgram,
              _urlDiary, _group, _description, _active);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isAddOrUpdate ? 'Criar estudante' : 'Editar estudante'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateData();
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.name,
            decoration: InputDecoration(
              labelText: 'Nome do estudante*',
            ),
            onSaved: (newValue) => _name = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.email,
            decoration: InputDecoration(
              labelText: 'Email do estudante*',
            ),
            onSaved: (newValue) => _email = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.phone,
            decoration: InputDecoration(
              labelText: 'Telefone do estudante*',
            ),
            onSaved: (newValue) => _phone = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.code,
            decoration: InputDecoration(
              labelText: 'Codigo do estudante',
            ),
            onSaved: (newValue) => _code = newValue,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Informe o que se pede.';
            //   }
            //   return null;
            // },
          ),
          TextFormField(
            initialValue: widget.urlProgram,
            decoration: InputDecoration(
              labelText: 'Link para programa do estudante',
            ),
            onSaved: (newValue) => _urlProgram = newValue,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Informe o que se pede.';
            //   }
            //   return null;
            // },
          ),
          TextFormField(
            initialValue: widget.urlDiary,
            decoration: InputDecoration(
              labelText: 'Link para diário do estudante',
            ),
            onSaved: (newValue) => _urlDiary = newValue,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Informe o que se pede.';
            //   }
            //   return null;
            // },
          ),
          TextFormField(
            initialValue: widget.group,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Classe do estudante',
            ),
            onSaved: (newValue) => _group = newValue,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Informe o que se pede.';
            //   }
            //   return null;
            // },
          ),
          TextFormField(
            initialValue: widget.description,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Descrição do estudante',
            ),
            onSaved: (newValue) => _description = newValue,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Informe o que se pede.';
            //   }
            //   return null;
            // },
          ),
          widget.isAddOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _active,
                  title: _active
                      ? Text('Estudante ativo')
                      : Text('Desativar estudante'),
                  onChanged: (value) {
                    setState(() {
                      _active = value;
                    });
                  },
                ),
          Container(
            height: 50,
          ),
        ],
      ),
    );
  }
}
