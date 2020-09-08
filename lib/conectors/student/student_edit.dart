import 'package:async_redux/async_redux.dart';
import 'package:bright/actions/student_action.dart';
import 'package:bright/states/app_state.dart';
import 'package:bright/uis/student/student_edit_ds.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  String code;
  String name;
  String email;
  String phone;
  String urlProgram;
  String urlDiary;
  String description;
  bool active;
  bool isAddOrUpdate;
  Function(String, String, String, String, String, String, String) onAdd;
  Function(String, String, String, String, String, String, String, bool)
      onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.code,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.urlProgram,
    @required this.urlDiary,
    @required this.description,
    @required this.active,
    @required this.isAddOrUpdate,
    @required this.onAdd,
    @required this.onUpdate,
  }) : super(equals: [
          code,
          name,
          email,
          phone,
          urlProgram,
          urlDiary,
          description,
          active,
          isAddOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isAddOrUpdate: state.studentState.studentCurrent.id == null,
        code: state.studentState.studentCurrent.code,
        name: state.studentState.studentCurrent.name,
        email: state.studentState.studentCurrent.email,
        phone: state.studentState.studentCurrent.phone,
        urlProgram: state.studentState.studentCurrent.urlProgram,
        urlDiary: state.studentState.studentCurrent.urlDiary,
        description: state.studentState.studentCurrent.description,
        active: state.studentState.studentCurrent?.active ?? false,
        onAdd: (String code, String name, String email, String phone,
            String urlProgram, String urlDiary, String description) {
          dispatch(AddDocStudentCurrentAsyncStudentAction(
            code: code,
            name: name,
            email: email,
            phone: phone,
            urlProgram: urlProgram,
            urlDiary: urlDiary,
            description: description,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String code,
            String name,
            String email,
            String phone,
            String urlProgram,
            String urlDiary,
            String description,
            bool active) {
          dispatch(UpdateDocStudentCurrentAsyncStudentAction(
            code: code,
            name: name,
            email: email,
            phone: phone,
            urlProgram: urlProgram,
            urlDiary: urlDiary,
            description: description,
            active: active,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class StudentEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => StudentEditDS(
        isAddOrUpdate: viewModel.isAddOrUpdate,
        code: viewModel.code,
        name: viewModel.name,
        email: viewModel.email,
        phone: viewModel.phone,
        urlProgram: viewModel.urlProgram,
        urlDiary: viewModel.urlDiary,
        description: viewModel.description,
        active: viewModel.active,
        onAdd: viewModel.onAdd,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
