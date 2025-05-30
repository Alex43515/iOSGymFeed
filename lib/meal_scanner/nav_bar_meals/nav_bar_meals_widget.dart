import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/meal_scanner/caloric_target/caloric_target_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'nav_bar_meals_model.dart';
export 'nav_bar_meals_model.dart';

class NavBarMealsWidget extends StatefulWidget {
  const NavBarMealsWidget({
    super.key,
    int? selectPageIndex,
    bool? hidden,
  })  : this.selectPageIndex = selectPageIndex ?? 1,
        this.hidden = hidden ?? false;

  final int selectPageIndex;
  final bool hidden;

  @override
  State<NavBarMealsWidget> createState() => _NavBarMealsWidgetState();
}

class _NavBarMealsWidgetState extends State<NavBarMealsWidget> {
  late NavBarMealsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarMealsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color(0xFF0A0A0A),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  MealScannerWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                    child: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).tertiary,
                      size: 24.0,
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'h7uy0gq4' /* Scan Meals */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: widget.selectPageIndex == 1
                              ? FlutterFlowTheme.of(context).tertiary
                              : FlutterFlowTheme.of(context).tertiary,
                          fontSize: 8.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) => InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: CaloricTargetWidget(),
                      );
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                      child: Icon(
                        Icons.food_bank_outlined,
                        color: FlutterFlowTheme.of(context).tertiary,
                        size: 24.0,
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'gpxjblso' /* Set caloric target */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: widget.selectPageIndex == 5
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).tertiary,
                            fontSize: 8.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
