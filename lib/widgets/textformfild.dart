import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxline;

  const TextForm({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      style: TextStyle(color: Colors.white),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF9EA6BA)),
        filled: true,
        fillColor: Color(0xFF292E38),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
