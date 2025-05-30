import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'report_widget.dart' show ReportWidget;
import 'package:flutter/material.dart';

class ReportModel extends FlutterFlowModel<ReportWidget> {
  ///  Local state fields for this page.

  bool eFatTrigger = false;

  bool uFatTrigger = false;

  bool leanMassTrigger = false;

  bool bfatTrigger = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  String? get choiceChipsValue1 =>
      choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) =>
      choiceChipsValueController1?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  String? get choiceChipsValue2 =>
      choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) =>
      choiceChipsValueController2?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController4;
  String? get choiceChipsValue4 =>
      choiceChipsValueController4?.value?.firstOrNull;
  set choiceChipsValue4(String? val) =>
      choiceChipsValueController4?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController5;
  String? get choiceChipsValue5 =>
      choiceChipsValueController5?.value?.firstOrNull;
  set choiceChipsValue5(String? val) =>
      choiceChipsValueController5?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController6;
  String? get choiceChipsValue6 =>
      choiceChipsValueController6?.value?.firstOrNull;
  set choiceChipsValue6(String? val) =>
      choiceChipsValueController6?.value = val != null ? [val] : [];
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController7;
  String? get choiceChipsValue7 =>
      choiceChipsValueController7?.value?.firstOrNull;
  set choiceChipsValue7(String? val) =>
      choiceChipsValueController7?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController8;
  String? get choiceChipsValue8 =>
      choiceChipsValueController8?.value?.firstOrNull;
  set choiceChipsValue8(String? val) =>
      choiceChipsValueController8?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController9;
  String? get choiceChipsValue9 =>
      choiceChipsValueController9?.value?.firstOrNull;
  set choiceChipsValue9(String? val) =>
      choiceChipsValueController9?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController10;
  String? get choiceChipsValue10 =>
      choiceChipsValueController10?.value?.firstOrNull;
  set choiceChipsValue10(String? val) =>
      choiceChipsValueController10?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController11;
  String? get choiceChipsValue11 =>
      choiceChipsValueController11?.value?.firstOrNull;
  set choiceChipsValue11(String? val) =>
      choiceChipsValueController11?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController12;
  String? get choiceChipsValue12 =>
      choiceChipsValueController12?.value?.firstOrNull;
  set choiceChipsValue12(String? val) =>
      choiceChipsValueController12?.value = val != null ? [val] : [];
  // State field(s) for TabBar widget.
  TabController? tabBarController3;
  int get tabBarCurrentIndex3 =>
      tabBarController3 != null ? tabBarController3!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController1?.dispose();
    tabBarController2?.dispose();
    tabBarController3?.dispose();
  }
}
