import 'package:autotager/app/core/values/app_translations.dart';
import 'package:autotager/app/initial_binding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "AutoTager",
      initialBinding: InitialBinding(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: const Locale('en'),
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
    ),
  );
}
