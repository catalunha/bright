import 'package:bright/models/firestore_model.dart';

class StudentModel extends FirestoreModel {
  static final String collection = 'student';

  String code;
  String name;
  String email;
  String phone;
  String urlProgram;
  String urlDiary;
  List<String> counterName;
  List<int> counterPoint;
  String description;
  bool active;

  StudentModel(
    String id, {
    this.code,
    this.email,
    this.name,
    this.urlProgram,
    this.urlDiary,
    this.description,
    this.active,
  }) : super(id);

  @override
  StudentModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('email')) email = map['email'];
      if (map.containsKey('phone')) phone = map['phone'];
      if (map.containsKey('urlProgram')) urlProgram = map['urlProgram'];
      if (map.containsKey('urlDiary')) urlDiary = map['urlDiary'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('active')) active = map['active'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    if (email != null) data['email'] = this.email;
    if (phone != null) data['phone'] = this.phone;
    if (urlProgram != null) data['urlProgram'] = this.urlProgram;
    if (urlDiary != null) data['urlDiary'] = this.urlDiary;
    if (description != null) data['description'] = this.description;
    if (active != null) data['active'] = this.active;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }

  @override
  String toString() {
    String _return = '';
    _return = _return + 'Código: $code';
    return _return;
  }
}
