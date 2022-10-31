import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class LetterButton extends StatelessWidget {
  const LetterButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 23.91.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: ThemeHelper.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: ThemeHelper.white.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
