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
    this.color = ThemeHelper.lightBlue,
    required this.buttonText,
  });
  bool get _active => onTap != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: _active ? 1 : 0.3,
        child: Container(
          alignment: Alignment.center,
          width: 80.r,
          height: 40.r,
          decoration: BoxDecoration(
            color:  color,
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2.h),
                      blurRadius: 10.r,
                      color: color.withOpacity(0.3),
                    ),
                  ],
          ),
          child: Text(
            buttonText.toUpperCase(),
            style: TextStyleHelper.helper9,
          ),
        ),
      ),
    );
  }
}
