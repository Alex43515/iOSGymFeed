import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/meal_scanner/nav_bar_meals/nav_bar_meals_widget.dart';
import '/index.dart';
import 'meal_collection_widget.dart' show MealCollectionWidget;
import 'package:flutter/material.dart';

class MealCollectionModel extends FlutterFlowModel<MealCollectionWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for Checkbox widget.
  Map<MealScannerRecord, bool> checkboxValueMap = {};
  List<MealScannerRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Model for NavBarMeals component.
  late NavBarMealsModel navBarMealsModel;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    navBarMealsModel = createModel(context, () => NavBarMealsModel());
  }

  @override
  void dispose() {
    navBarMealsModel.dispose();
  }
}
