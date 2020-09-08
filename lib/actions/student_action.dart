import 'package:async_redux/async_redux.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

// +++ Actions Async
class GetDocsStudentListAsyncStudentAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsStudentListAsyncStudentAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(StudentModel.collection);
    // .where('active', isEqualTo: true);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map(
            (docSnap) => StudentModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
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
  final String description;

  AddDocStudentCurrentAsyncStudentAction({
    this.code,
    this.name,
    this.email,
    this.phone,
    this.urlProgram,
    this.urlDiary,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('AddDocStudentCurrentAsyncStudentAction...');
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
    studentModel.description = description;
    studentModel.active = true;
    var docRef = await firestore
        .collection(StudentModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc) throw const UserException("Este estudante já foi cadastrado.");
    await firestore
        .collection(StudentModel.collection)
        .add(studentModel.toMap());
    return null;
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
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
  final String description;
  final bool active;

  UpdateDocStudentCurrentAsyncStudentAction({
    this.code,
    this.name,
    this.email,
    this.phone,
    this.urlProgram,
    this.urlDiary,
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
