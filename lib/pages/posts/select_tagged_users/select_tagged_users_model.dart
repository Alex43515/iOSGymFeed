import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_tagged_users_widget.dart' show SelectTaggedUsersWidget;
import 'package:flutter/material.dart';

class SelectTaggedUsersModel extends FlutterFlowModel<SelectTaggedUsersWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<UsersRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
