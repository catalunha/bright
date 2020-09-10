import 'package:async_redux/async_redux.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/models/user_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/states/types_states.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/meet_model.dart';

// +++ Actions Sync
class SetStudentCurrentSyncStudentAction extends ReduxAction<AppState> {
  final String id;

  SetStudentCurrentSyncStudentAction(this.id);

  @override
  AppState reduce() {
    StudentModel studentModel;
    if (id == null) {
      studentModel = StudentModel(null);
    } else {
      StudentModel studentModelTemp = state.studentState.studentList
          .firstWhere((element) => element.id == id);
      studentModel =
          StudentModel(studentModelTemp.id).fromMap(studentModelTemp.toMap());
    }
    return state.copyWith(
      studentState: state.studentState.copyWith(
        studentCurrent: studentModel,
      ),
    );
  }
}

class SetStudentFilterSyncStudentAction extends ReduxAction<AppState> {
  final StudentFilter studentFilter;

  SetStudentFilterSyncStudentAction(this.studentFilter);

  @override
  AppState reduce() {
    return state.copyWith(
      studentState: state.studentState.copyWith(
        studentFilter: studentFilter,
      ),
    );
  }

  void after() => dispatch(GetDocsStudentListAsyncStudentAction());
}

// +++ Actions Async
class GetDocsStudentListAsyncStudentAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsStudentListAsyncStudentAction...');
    Firestore firestore = Firestore.instance;
    Query collRef;
    if (state.studentState.studentFilter == StudentFilter.active) {
      collRef = firestore
          .collection(StudentModel.collection)
          .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
          .where('active', isEqualTo: true);
    } else if (state.studentState.studentFilter == StudentFilter.inactive) {
      collRef = firestore
          .collection(StudentModel.collection)
          .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
          .where('active', isEqualTo: false);
    }
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map(
            (docSnap) => StudentModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();

    listDocs.sort((a, b) => a.name.compareTo(b.name));
    return state.copyWith(
      studentState: state.studentState.copyWith(
        studentList: listDocs,
      ),
    );
  }
}

class AddDocStudentCurrentAsyncStudentAction extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String email;
  final String phone;
  final String urlProgram;
  final String urlDiary;
  final String company;
  final String group;
  final String description;

  AddDocStudentCurrentAsyncStudentAction({
    this.code,
    this.name,
    this.email,
    this.phone,
    this.urlProgram,
    this.urlDiary,
    this.company,
    this.group,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('AddDocStudentCurrentAsyncStudentAction...');
    Firestore firestore = Firestore.instance;
    StudentModel studentModel =
        StudentModel(state.studentState.studentCurrent.id)
            .fromMap(state.studentState.studentCurrent.toMap());
    studentModel.userRef = UserModel(state.loggedState.userModelLogged.id)
        .fromMap(state.loggedState.userModelLogged.toMapRef());
    studentModel.code = code;
    studentModel.name = name;
    studentModel.email = email;
    studentModel.phone = phone;
    studentModel.urlProgram = urlProgram;
    studentModel.urlDiary = urlDiary;
    studentModel.description = description;
    studentModel.company = company;
    studentModel.group = group;
    studentModel.active = true;
    // var docRef = await firestore
    //     .collection(StudentModel.collection)
    //     .where('code', isEqualTo: code)
    //     .getDocuments();
    // bool doc = docRef.documents.length != 0;
    // if (doc) throw const UserException("Este estudante já foi cadastrado.");
    await firestore
        .collection(StudentModel.collection)
        .add(studentModel.toMap());
    return null;
  }

  // @override
  // Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsStudentListAsyncStudentAction());
}

class UpdateDocStudentCurrentAsyncStudentAction extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String email;
  final String phone;
  final String urlProgram;
  final String urlDiary;
  final String company;
  final String group;
  final String description;
  final bool active;

  UpdateDocStudentCurrentAsyncStudentAction({
    this.code,
    this.name,
    this.email,
    this.phone,
    this.urlProgram,
    this.urlDiary,
    this.company,
    this.group,
    this.description,
    this.active,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocStudentCurrentAsyncStudentAction...');
    Firestore firestore = Firestore.instance;
    StudentModel studentModel =
        StudentModel(state.studentState.studentCurrent.id)
            .fromMap(state.studentState.studentCurrent.toMap());
    studentModel.code = code;
    studentModel.name = name;
    studentModel.email = email;
    studentModel.phone = phone;
    studentModel.urlProgram = urlProgram;
    studentModel.urlDiary = urlDiary;
    studentModel.company = company;
    studentModel.group = group;
    studentModel.description = description;
    studentModel.active = active;
    await firestore
        .collection(StudentModel.collection)
        .document(studentModel.id)
        .updateData(studentModel.toMap());
    return null;
  }

  @override
  void after() => dispatch(GetDocsStudentListAsyncStudentAction());
}

class ReportAsyncStudentAction extends ReduxAction<AppState> {
  final dynamic start;
  final dynamic end;

  ReportAsyncStudentAction({this.start, this.end});
  @override
  Future<AppState> reduce() async {
    print('ReportAsyncStudentAction... $start $end');
    Firestore firestore = Firestore.instance;
    Query collRef;
    collRef = firestore
        .collection(MeetModel.collection)
        .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
        .where('start', isGreaterThanOrEqualTo: start)
        .where('start', isLessThanOrEqualTo: end);

    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => MeetModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();

    listDocs.sort((a, b) => a.start.compareTo(b.start));
    String _data =
        'Data|Hora|Duração|Investimento|Empresa|Turma|Aluno|Conteúdo';
    listDocs.forEach((meet) {
      _data = _data +
          '\n' +
          '${DateFormat('dd-MM-yyyy').format(meet.start)}' +
          '|' +
          '${DateFormat('kk:mm').format(meet.start)}' +
          '|' +
          '${(meet.end.difference(meet.start)).toString().split('.').first.padLeft(8, "0").substring(0, 6).replaceFirst(':', 'h').replaceFirst(':', 'm')}' +
          '|' +
          (meet.paid
              ? 'R\$ ${(meet.price / 100).toStringAsFixed(2)}'
              : '*R\$ ${(meet.price / 100).toStringAsFixed(2)}') +
          '|' +
          '${meet.studentRef.company}' +
          '|' +
          '${meet.studentRef.group}' +
          '|' +
          '${meet.studentRef.name}' +
          '|' +
          '"${meet.topic}"';
    });

    FlutterClipboard.copy(_data).then((value) {
      print('copied');
      // scaffoldState.currentState.showSnackBar(SnackBar(
      //     content:
      //         Text('Aula copiada para texto. CTRL-c concluído.')));
    });

    return null;
  }

  @override
  void before() => dispatch(WaitAction.add(this));
  @override
  void after() => dispatch(WaitAction.remove(this));
}
