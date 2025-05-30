// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> fetchWearableData(DateTime startDate, DateTime endDate) async {
  print("🟡 Initializing Health...");
  Health health = Health();

  try {
    await health.configure();
    print("🟢 Health configured.");
  } catch (e) {
    print("🔴 Error during configure(): $e");
  }

  // ✅ Request permissions BEFORE asking Health Connect
  await Permission.activityRecognition.request();
  await Permission.sensors.request();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
  ];

  print("🟡 Requesting authorization...");
  bool authorized = false;

  try {
    authorized = await health.requestAuthorization(types);
    print("🟢 Authorization result: $authorized");
  } catch (e) {
    print("🔴 Error during requestAuthorization(): $e");
  }

  if (!authorized) {
    throw Exception('Authorization denied');
  }

  print("🟡 Fetching health data...");
  List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
    startTime: startDate,
    endTime: endDate,
    types: types,
  );

  print("🟢 Retrieved ${healthData.length} health data points.");

  List<Map<String, dynamic>> data = healthData
      .map((e) => {
            'type': e.typeString,
            'value': e.value,
            'unit': e.unitString,
            'date': e.dateFrom.toIso8601String(),
          })
      .toList();

  return jsonEncode(data);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
