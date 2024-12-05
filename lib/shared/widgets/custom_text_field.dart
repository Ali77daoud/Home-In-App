import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final bool isObscure;
  final TextInputType textInputType;
  final int maxLines;
  final bool isHintColor;
  final double contentPadding;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.isHintColor = false,
      this.onChange,
      this.onFieldSubmitted,
      this.isObscure = false,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.labelText = '',
      this.contentPadding = 10});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      cursorColor: AppColors.primaryDark,
      validator: validator,
      obscureText: isObscure,
      maxLines: maxLines,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(
        color: AppColors.blackDark,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
        fontSize: 14,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
          fontSize: 12,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.normal,
          fontFamily: 'Tajawal',
          fontSize: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
