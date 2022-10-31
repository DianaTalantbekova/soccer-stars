import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class HintButton extends StatelessWidget {
  const HintButton({
    super.key,
    required this.asset,
    this.onTap,
    this.color = ThemeHelper.lightBlue,
  });

  final String asset;
  final VoidCallback? onTap;
  final Color color;

  bool get _active => onTap != null;

  bool get _isPng => asset.contains('.png');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: _active ? 1.0 : 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.r,
              sigmaY: 10.r,
            ),
            child: Container(
              alignment: Alignment.center,
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: ThemeHelper.white.withOpacity(0.1),
                ),
              ),
              child: Center(
                child: _buildBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isPng) {
      return SizedBox(
        width: 14.w,
        height: 14.h,
        child: Image.asset(asset),
      );
    }
    return Text(
      asset,
      style: TextStyleHelper.helper7,
    );
  }
}
