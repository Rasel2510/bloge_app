import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxline;

  // Text behavior
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;

  // Decoration
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius; // 👈 simple number
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;

  const TextForm({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.maxline,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.autovalidateMode,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.borderRadius,  
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? 8.r);

    OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: color),
    );

    return TextFormField(
      maxLines: maxline ?? 1,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTap: onTap,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      style: TextStyle(color: textColor ?? Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? const Color(0xFF9EA6BA)),
        filled: true,
        fillColor: fillColor ?? const Color(0xFF292E38),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: _border(borderColor ?? Colors.transparent),
        focusedBorder: _border(borderColor ?? Colors.transparent),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
      ),
    );
  }
}
