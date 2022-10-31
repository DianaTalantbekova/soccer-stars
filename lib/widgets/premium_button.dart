import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({
    super.key,
    this.onTap,
    required this.text,
    this.color = ThemeHelper.lightBlue,
  });
  final String text;
  final VoidCallback? onTap;
  final Color color;

  bool get _active => onTap != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: _active ? 1: 0.3,
        child: Container(
          alignment: Alignment.center,
          width: 343.w,
          height: 72.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: [
                    BoxShadow(
                      color: ThemeHelper.white.withOpacity(0.15),
                      offset: Offset(
                        0.r,
                        4.r,
                      ),
                      blurRadius: 22.0,
                    ),
                  ],
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyleHelper.helper1,
          ),
        ),
      ),
    );
  }
}
