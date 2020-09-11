import 'package:async_redux/async_redux.dart';
import 'package:bright/models/meet_model.dart';
import 'package:bright/models/student_model.dart';
import 'package:bright/models/user_model.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/states/types_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// +++ Actions Sync
class SetMeetCurrentSyncMeetAction extends ReduxAction<AppState> {
  final String id;

  SetMeetCurrentSyncMeetAction(this.id);

  @override
  AppState reduce() {
    MeetModel meetModel;
    if (id == null) {
      meetModel = MeetModel(null);
    } else {
      MeetModel meetModelTemp =
          state.meetState.meetList.firstWhere((element) => element.id == id);
      meetModel = MeetModel(meetModelTemp.id).fromMap(meetModelTemp.toMap());
    }
    return state.copyWith(
      meetState: state.meetState.copyWith(
        meetCurrent: meetModel,
      ),
    );
  }
}

class SetMeetFilterSyncMeetAction extends ReduxAction<AppState> {
  final MeetFilter meetFilter;

  SetMeetFilterSyncMeetAction(this.meetFilter);

  @override
  AppState reduce() {
    return state.copyWith(
      meetState: state.meetState.copyWith(
        meetFilter: meetFilter,
      ),
    );
  }

  void after() => dispatch(GetDocsMeetListAsyncMeetAction());
}

// +++ Actions Async
class GetDocsMeetListAsyncMeetAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsMeetListAsyncMeetAction...');
    Firestore firestore = Firestore.instance;

    // final collRef = firestore.collection(MeetModel.collection);
    // .where('active', isEqualTo: true);

    Query collRef;
    if (state.meetState.meetFilter == MeetFilter.paid) {
      collRef = firestore
          .collection(MeetModel.collection)
          .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
          .where('studentRef.id',
              isEqualTo: state.studentState.studentCurrent.id)
          .where('paid', isEqualTo: true);
    } else if (state.meetState.meetFilter == MeetFilter.notpaid) {
      collRef = firestore
          .collection(MeetModel.collection)
          .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
          .where('studentRef.id',
              isEqualTo: state.studentState.studentCurrent.id)
          .where('paid', isEqualTo: false);
    }

    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => MeetModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();

    listDocs.sort((a, b) => a.start.compareTo(b.start));

    return state.copyWith(
      meetState: state.meetState.copyWith(
        meetList: listDocs,
      ),
    );
  }
}

class AddDocMeetCurrentAsyncMeetAction extends ReduxAction<AppState> {
  final String classAct;
  final String homeAct;
  final int price;
  final dynamic start;
  final dynamic end;

  AddDocMeetCurrentAsyncMeetAction({
    this.classAct,
    this.homeAct,
    this.price,
    this.start,
    this.end,
  });
  @override
  Future<AppState> reduce() async {
    print('AddDocMeetCurrentAsyncMeetAction...');
    Firestore firestore = Firestore.instance;
    MeetModel meetModel = MeetModel(state.meetState.meetCurrent.id)
        .fromMap(state.meetState.meetCurrent.toMap());
    meetModel.userRef = UserModel(state.loggedState.userModelLogged.id)
        .fromMap(state.loggedState.userModelLogged.toMapRef());
    meetModel.studentRef = StudentModel(state.studentState.studentCurrent.id)
        .fromMap(state.studentState.studentCurrent.toMapRef());
    meetModel.classAct = classAct;
    meetModel.homeAct = homeAct;
    meetModel.price = price;
    meetModel.start = start;
    meetModel.end = end;
    meetModel.paid = false;
    await firestore.collection(MeetModel.collection).add(meetModel.toMap());
    return null;
  }

  @override
  void after() => dispatch(GetDocsMeetListAsyncMeetAction());
}

class UpdateDocMeetCurrentAsyncMeetAction extends ReduxAction<AppState> {
  final String classAct;
  final String homeAct;
  final int price;
  final dynamic start;
  final dynamic end;
  final bool paid;

  UpdateDocMeetCurrentAsyncMeetAction({
    this.classAct,
    this.homeAct,
    this.price,
    this.start,
    this.end,
    this.paid,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocMeetCurrentAsyncMeetAction...');
    Firestore firestore = Firestore.instance;
    MeetModel meetModel = MeetModel(state.meetState.meetCurrent.id)
        .fromMap(state.meetState.meetCurrent.toMap());
    meetModel.studentRef = StudentModel(state.studentState.studentCurrent.id)
        .fromMap(state.studentState.studentCurrent.toMapRef());
    meetModel.classAct = classAct;
    meetModel.homeAct = homeAct;
    meetModel.price = price;
    meetModel.start = start;
    meetModel.end = end;
    meetModel.paid = paid;
    await firestore
        .collection(MeetModel.collection)
        .document(meetModel.id)
        .updateData(meetModel.toMap());
    return null;
  }

  @override
  void after() => dispatch(GetDocsMeetListAsyncMeetAction());
}

class CopyCurrentMeetToAnotherStudentSyncMeetAction
    extends ReduxAction<AppState> {
  final String studentId;
  CopyCurrentMeetToAnotherStudentSyncMeetAction(this.studentId);
  @override
  Future<AppState> reduce() async {
    print('CopyCurrentMeetToAnotherStudentSyncMeetAction...');
    Firestore firestore = Firestore.instance;
    MeetModel meetModelNew = MeetModel(state.meetState.meetCurrent.id)
        .fromMap(state.meetState.meetCurrent.toMap());
    StudentModel studentModelTemp = state.studentState.studentList
        .firstWhere((element) => element.id == studentId);
    meetModelNew.studentRef = studentModelTemp;
    await firestore.collection(MeetModel.collection).add(meetModelNew.toMap());
    return null;
  }
}
