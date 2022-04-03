import 'package:autotager/app/core/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../core/values/app_colors.dart';

void showSnackBar(String title, String message,
    {Color? color,
    String? iconSVG,
    int? durationInSeconds,
    Duration? duration,
    List<Widget>? actions,
    OverlayState? overlayState,
    required BuildContext overlayContext}) {
  bool isTablet = Responsive.isTablet(Get.context!);

  showTopSnackBar(
      overlayContext,
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconSVG!,
                width: isTablet ? 25 : 50.0,
                height: isTablet ? 25 : 50.0,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 18.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 16.0,
                        color: AppColors.dimmedTextColor,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                    if (actions != null)
                      Column(
                        children: actions,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      showOutAnimationDuration: const Duration(milliseconds: 800),
      overlayState: overlayState,
      displayDuration: duration ?? Duration(seconds: durationInSeconds!));
}
