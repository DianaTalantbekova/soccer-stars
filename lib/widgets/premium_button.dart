import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class PremiumButton extends StatefulWidget {
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
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        width: 343.w,
        height: 72.h,
        decoration: BoxDecoration(
          color: widget._active ? widget.color : widget.color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: widget._active
              ? [
                  BoxShadow(
                    color: ThemeHelper.white.withOpacity(0.15),
                    offset: Offset(
                      0.r,
                      4.r,
                    ),
                    blurRadius: 22.0,
                  ),
                ]
              : null,
        ),
        child: Text(
          widget.text.toUpperCase(),
          style: TextStyleHelper.helper1,
        ),
      ),
    );
  }
}
