import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';

class AppBarWidget extends StatelessWidget {
  final int coins;
  final int currentPlayer;
  final int totalPlayers;
  const AppBarWidget({
    Key? key,
    required this.coins,
    required this.currentPlayer,
    required this.totalPlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 56.h,
      child: AppBar(
        backgroundColor: ThemeHelper.blue94,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            text: '$coins '.toUpperCase(),
            style: TextStyleHelper.helper4,
            children: [
              TextSpan(
                text: 'coins'.toUpperCase(),
                style: TextStyleHelper.helper5,
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 13.r,
              vertical: 19.r,
            ),
            child: Text(
              '$currentPlayer/$totalPlayers',
              style: TextStyleHelper.helper6,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: ThemeHelper.borderColor,
            height: 1.h,
          ),
        ),
      ),
    );
  }
}
