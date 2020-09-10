import 'package:bright/models/firestore_model.dart';
import 'package:bright/models/user_model.dart';

class StudentModel extends FirestoreModel {
  static final String collection = 'student';

  UserModel userRef;
  String code;
  String name;
  String email;
  String phone;
  String urlProgram;
  String urlDiary;
  String company;
  String group;
  String description;
  bool active;
  // List<String> counterName;
  // List<int> counterPoint;

  StudentModel(
    String id, {
    this.userRef,
    this.code,
    this.email,
    this.name,
    this.urlProgram,
    this.urlDiary,
    this.company,
    this.group,
    this.description,
    this.active,
  }) : super(id);

  @override
  StudentModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('email')) email = map['email'];
      if (map.containsKey('phone')) phone = map['phone'];
      if (map.containsKey('urlProgram')) urlProgram = map['urlProgram'];
      if (map.containsKey('urlDiary')) urlDiary = map['urlDiary'];
      if (map.containsKey('company')) company = map['company'];
      if (map.containsKey('group')) group = map['group'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('active')) active = map['active'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    if (email != null) data['email'] = this.email;
    if (phone != null) data['phone'] = this.phone;
    if (urlProgram != null) data['urlProgram'] = this.urlProgram;
    if (urlDiary != null) data['urlDiary'] = this.urlDiary;
    if (company != null) data['company'] = this.company;
    if (group != null) data['group'] = this.group;
    if (description != null) data['description'] = this.description;
    if (active != null) data['active'] = this.active;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    if (company != null) data['company'] = this.company;
    if (group != null) data['group'] = this.group;
    return data;
  }

  @override
  String toString() {
    String _return = '';
    // _return = _return + 'id: $id';
    _return = _return + 'Email: $email';
    _return = _return + '\nTel.: $phone';
    _return = _return + '\nC/C: $company - $group';
    // _return = _return + '\nCódigo: $code';
    return _return;
  }
}
