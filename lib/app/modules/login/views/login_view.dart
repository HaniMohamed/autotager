import 'package:auto_size_text/auto_size_text.dart';
import 'package:autotager/app/core/values/app_colors.dart';
import 'package:autotager/app/core/values/strings.dart';
import 'package:autotager/app/modules/login/components/decorated_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF262D34),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                            child: AutoSizeText(
                              controller.loginView.isTrue
                                  ? AppStrings.login.capitalizeFirst!
                                  : AppStrings.register.capitalizeFirst!,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: DecoratedTextField(
                                    controller: controller.usernameController,
                                    hint: AppStrings.userNameHint,
                                    label: AppStrings.userName,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (controller.loginView.isFalse)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DecoratedTextField(
                                      controller: controller.emailController,
                                      hint: AppStrings.emailHint,
                                      label: AppStrings.email,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: DecoratedTextField(
                                    controller: controller.passwordController,
                                    obscure:
                                        !controller.passwordVisibility.value,
                                    hint: AppStrings.passwordHint,
                                    label: AppStrings.password,
                                    suffix: InkWell(
                                      onTap: () => controller
                                              .passwordVisibility.value =
                                          !controller.passwordVisibility.value,
                                      child: Icon(
                                        controller.passwordVisibility.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppColors.dimmedTextColor,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                controller.loading.value
                                    ? Container(
                                        height: 45,
                                        width: 45,
                                        padding: EdgeInsets.all(8),
                                        child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        onPressed: () => controller.btnAction(),
                                        child: Text(!controller.loginView.value
                                            ? AppStrings.newAccount
                                            : AppStrings.login),
                                      ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 2,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                            color: Color(0xFFDBE2E7),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      controller.loginView.value =
                                          !controller.loginView.value;
                                    },
                                    child: Text(controller.loginView.value
                                        ? AppStrings.newAccount
                                        : AppStrings.login)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
