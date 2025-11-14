import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? fcolor;
  final Color bcolor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 12,
    required this.bcolor,
    this.fcolor,
    SizedBox? child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: fcolor,
          backgroundColor: bcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
