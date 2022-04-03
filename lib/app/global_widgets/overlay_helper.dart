import 'dart:ui';

import 'package:autotager/app/core/values/app_icons.dart';
import 'package:autotager/app/global_widgets/snack_bar_helper.dart';
import 'package:flutter/material.dart';

class OverlayHelper {
  static Map<int, OverlayEntry?> _lastOverlays = {};

  // TODO: refactor to use the theme colors
  static Color successColor = const Color(0xffE9F6ED);
  static Color errorColor = const Color(0xffF6E7E4);
  static Color infoColor = const Color(0xffE3ECF7);
  static Color warningColor = const Color(0xffFAF3E6);
  static Color generalColor = const Color(0xFFEEEDF2);

  static int _toastLayerIndex = 2, _progressLayerIndex = 1;

  static void showOverlay(BuildContext context,
      {int? durationInSeconds = 3,
      Duration? duration,
      int layerIndex = 0,
      required Widget widget}) {
    var _overlay = OverlayEntry(builder: (BuildContext context) => widget);

    if (_lastOverlays[layerIndex] != null) {
      _lastOverlays[layerIndex]!.remove();
      _lastOverlays[layerIndex] = null;
    }
    var o = Overlay.of(context);
    //o = NavigationHelper.navigatorKey.currentState.overlay;
    if (o == null) {
      return;
    }
    o.insert(_overlay);
    _lastOverlays[layerIndex] = _overlay;

    if (durationInSeconds == null) return;

    Future.delayed(duration ?? Duration(seconds: durationInSeconds), () {
      if (_lastOverlays[layerIndex] == null ||
          _lastOverlays[layerIndex] != _overlay) return;
      _lastOverlays[layerIndex]!.remove();
      _lastOverlays[layerIndex] = null;
    });
  }

  static void hideOverlay([int layerIndex = 0]) {
    if (_lastOverlays[layerIndex] != null) {
      _lastOverlays[layerIndex]!.remove();
      _lastOverlays[layerIndex] = null;
    }
  }

  static void hideAllOverlays() {
    for (int index in _lastOverlays.keys) {
      hideOverlay(index);
    }
  }

  // toast methods

  static void showSuccessToast(BuildContext context, String text,
      {int seconds = 10}) {
    showSnackBar("Success", text,
        overlayContext: context,
        color: successColor,
        iconSVG: AppIcons.success,
        durationInSeconds: seconds);
  }

  static void showGeneralToast(
      BuildContext context, String title, String message,
      {int seconds = 10}) {
    showSnackBar(title, message,
        overlayContext: context,
        color: generalColor,
        iconSVG: AppIcons.information,
        durationInSeconds: seconds);
  }

  static void showErrorToast(BuildContext context, String text,
      {int seconds = 10}) {
    showSnackBar("Error", text,
        overlayContext: context,
        color: errorColor,
        iconSVG: AppIcons.error,
        durationInSeconds: seconds);
  }

  static void showInfoToast(BuildContext context, String text,
      {int seconds = 10}) {
    showSnackBar("Information", text,
        overlayContext: context,
        color: infoColor,
        iconSVG: AppIcons.information,
        durationInSeconds: seconds);
  }

  static void showWarningToast(BuildContext context, String text,
      {int seconds = 10}) {
    showSnackBar("Warning", text,
        overlayContext: context,
        color: warningColor,
        iconSVG: AppIcons.warning,
        durationInSeconds: seconds);
  }

  // progress methods
  // layer index 1 is preserved for the progress indicator

  static void showProgressOverlay(BuildContext context,
      {required String text, durationInSeconds = 65}) {
    clearFocus(context);
    showOverlay(context,
        layerIndex: _progressLayerIndex,
        durationInSeconds: durationInSeconds,
        widget: OverlayProgress(text));
  }

  static void hideProgressOverlay() {
    hideOverlay(_progressLayerIndex);
  }

  static void clearFocus(BuildContext context) {
    //if (context == null) return;
    FocusScope.of(context).unfocus();
  }
}

// region Progress Overlay

class OverlayProgress extends StatefulWidget {
  final String text;

  OverlayProgress(this.text);

  @override
  _OverlayProgressState createState() {
    return _OverlayProgressState();
  }
}

class _OverlayProgressState extends State<OverlayProgress> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Center(
          child: Material(
            elevation: 2,
            color: Colors.white,
            type: MaterialType.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              side: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// endregion
