import 'package:autotager/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';

class DecoratedTextField extends StatelessWidget {
  const DecoratedTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.suffix,
    this.obscure = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final Widget? suffix;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.dimmedTextColor,
              ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.dimmedTextColor,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.dimmedTextColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
          suffixIcon: suffix),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Color(0xFF2B343A),
          ),
    );
  }
}
