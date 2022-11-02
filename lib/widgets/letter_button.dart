import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/models/character.dart';

class LetterButton extends StatelessWidget {
  const LetterButton({
    Key? key,
    this.onTap, required this.character,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Character character;

  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.center,
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: ThemeHelper.darkBlue,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: ThemeHelper.white.withOpacity(0.1),
              ),
            ),
            child: Text(
              character.char,
              style: TextStyleHelper.helper8,
            ),
          ),
        ),
      ),
    );
  }
}
