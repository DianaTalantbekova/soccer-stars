import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class CardButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;
  final String buttonText;
  const CardButton({
    super.key,
    this.onTap,
    this.color = ThemeHelper.lightblue,
    required this.buttonText,
  });
  bool get _active => onTap != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: _active ? color : color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: _active
            ? [
                BoxShadow(
                  offset: Offset(0, 2.h),
                  blurRadius: 10.r,
                  color: color.withOpacity(0.3),
                ),
              ]
            : null,
      ),
      child: Text(
        buttonText.toUpperCase(),
        style: TextStyleHelper.helper9,
      ),
    );
  }
}
