import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'jebemtimater_model.dart';
export 'jebemtimater_model.dart';
import 'package:health/health.dart';
import 'dart:convert';

class JebemtimaterWidget extends StatefulWidget {
  const JebemtimaterWidget({super.key});

  static String routeName = 'jebemtimater';
  static String routePath = 'jebemtimater';

  @override
  State<JebemtimaterWidget> createState() => _JebemtimaterWidgetState();
}

class _JebemtimaterWidgetState extends State<JebemtimaterWidget> {
  late JebemtimaterModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> parsedHealthData = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JebemtimaterModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));

    _loadWearableData();
  }

  void _loadWearableData() {
    final wearableData = currentUserDocument?.wearableData;
    if (wearableData != null && wearableData.isNotEmpty) {
      try {
        parsedHealthData = jsonDecode(wearableData);
      } catch (e) {
        print("❌ Failed to parse wearableData: $e");
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: () async {
              context.pushNamed('Feed');
            },
            child: Text(
              'Wearable Test',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      print("🟡 Initializing Health...");
                      final health = Health();
                      await health.configure();
                      print("🟢 Health configured.");

                      final types = [
                        HealthDataType.STEPS,
                        HealthDataType.ACTIVE_ENERGY_BURNED,
                        HealthDataType.HEART_RATE,
                      ];

                      print("🟡 Requesting authorization...");
                      final authorized =
                          await health.requestAuthorization(types);
                      print("🟢 Authorization result: $authorized");

                      if (!authorized) {
                        throw Exception("Authorization denied");
                      }

                      print("🟡 Fetching health data...");
                      final data = await health.getHealthDataFromTypes(
                        startTime: functions.getMidnightToday()!,
                        endTime: getCurrentTimestamp,
                        types: types,
                      );

                      final formatted = data
                          .map((e) => {
                                'type': e.typeString,
                                'value': {
                                  '__type': 'NumericHealthValue',
                                  'numericValue': e.value,
                                },
                                'unit': e.unitString,
                                'date': e.dateFrom.toIso8601String(),
                              })
                          .toList();

                      final result = jsonEncode(formatted);

                      await currentUserReference!.update(
                        createUsersRecordData(wearableData: result),
                      );

                      setState(() {
                        parsedHealthData = formatted;
                      });

                      print("✅ Data saved to Firestore");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ Data saved successfully'),
                        ),
                      );
                    } catch (e) {
                      print("❌ Error: $e");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❌ Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text("Connect Health"),
                ),
                const SizedBox(height: 30),

                // Parsed wearable data display
                if (parsedHealthData.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: parsedHealthData.length,
                    itemBuilder: (context, index) {
                      final entry = parsedHealthData[index];
                      final value = entry['value'] is Map
                          ? entry['value']['numericValue'] ?? 'N/A'
                          : entry['value'] ?? 'N/A';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: ListTile(
                          leading: Icon(Icons.favorite),
                          title: Text("${entry['type']}"),
                          subtitle:
                              Text("Value: $value ${entry['unit'] ?? ''}"),
                          trailing: Text(
                            entry['date'] != null
                                ? DateTime.parse(entry['date'])
                                    .toLocal()
                                    .toString()
                                : '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No wearable data available.',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
