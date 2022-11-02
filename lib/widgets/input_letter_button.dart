import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/models/models.dart';

class InputLetterButton extends StatelessWidget {
  const InputLetterButton({
    super.key,
    this.onTap,
    required this.character,
  });

  final VoidCallback? onTap;
  final Character character;

  @override
  Widget build(BuildContext context) {
    if (character == Character.space()) {
      return SizedBox(
        width: 23.91.w,
        height: 40.h,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.r,
            sigmaY: 10.r,
          ),
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
            child: Center(
              child: Text(
                character.char,
                style: TextStyleHelper.helper3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
