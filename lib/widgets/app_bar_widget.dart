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
    return Container(
      alignment: Alignment.center,
      width: 375.r,
      height: 56.r,
      decoration: BoxDecoration(
        color: ThemeHelper.darkBlue.withOpacity(0.94),
        border: Border(
          bottom: BorderSide(
            color: ThemeHelper.black.withOpacity(0.1),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 56.r,
            height: 56.r,
          ),
          RichText(
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
          SizedBox(
            width: 56.r,
            height: 56.r,
            child: Center(
              child: Text(
                '${currentPlayer + 1}/$totalPlayers',
                style: TextStyleHelper.helper6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
