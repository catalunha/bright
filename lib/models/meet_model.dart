import 'package:bright/models/firestore_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/models/user_model.dart';
import 'package:intl/intl.dart';

class MeetModel extends FirestoreModel {
  static final String collection = 'meet';

  UserModel userRef;
  StudentModel studentRef;
  dynamic start;
  dynamic end;
  int price;
  String classAct;
  String homeAct;

  bool paid;

  MeetModel(
    String id, {
    this.userRef,
    this.studentRef,
    this.classAct,
    this.homeAct,
    this.price,
    this.start,
    this.end,
    this.paid,
  }) : super(id);

  @override
  MeetModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      studentRef = map.containsKey('studentRef') && map['studentRef'] != null
          ? StudentModel(map['studentRef']['id']).fromMap(map['studentRef'])
          : null;
      if (map.containsKey('classAct')) classAct = map['classAct'];
      if (map.containsKey('homeAct')) homeAct = map['homeAct'];
      if (map.containsKey('price')) price = map['price'];
      start = map.containsKey('start') && map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['start'].millisecondsSinceEpoch)
          : null;
      end = map.containsKey('end') && map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['end'].millisecondsSinceEpoch)
          : null;
      if (map.containsKey('paid')) paid = map['paid'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (this.studentRef != null) {
      data['studentRef'] = this.studentRef.toMapRef();
    }
    if (classAct != null) data['classAct'] = this.classAct;
    if (homeAct != null) data['homeAct'] = this.homeAct;
    if (price != null) data['price'] = this.price;
    data['start'] = this.start;
    data['end'] = this.end;
    if (paid != null) data['paid'] = this.paid;

    return data;
  }

  String labelTo(String field) {
    String _return = '';
    if (field == 'start') {
      _return = '${DateFormat('dd-MM-yyyy kk:mm').format(start)}';
    }
    if (field == 'startDate') {
      _return = '${DateFormat('dd-MM-yyyy').format(start)}';
    }
    if (field == 'startTime') {
      _return = '${DateFormat('kk:mm').format(start)}';
    }
    if (field == 'betweenStartToEnd') {
      _return =
          '${(end.difference(start)).toString().split('.').first.padLeft(8, "0").substring(0, 6).replaceFirst(':', 'h').replaceFirst(':', 'm')}';
    }
    if (field == 'price') {
      _return = 'R\$ ${(price / 100).toStringAsFixed(2)}';
    }
    return _return;
  }
}
