import 'package:bright/models/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'user';
  String name;
  String email;

  UserModel(
    String id, {
    this.name,
    this.email,
  }) : super(id);

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('email')) email = map['email'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (email != null) data['email'] = this.email;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }

  UserModel copy() {
    return UserModel(
      this.id,
      name: this.name,
      email: this.email,
    );
  }
}
