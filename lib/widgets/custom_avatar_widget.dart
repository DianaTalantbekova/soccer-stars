import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/models/models.dart';

class CustomAvatarWidget extends StatelessWidget {
  const CustomAvatarWidget({
    Key? key,
    this.opened = false,
    required this.player,
  }) : super(key: key);
  final bool opened;
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 103.r,
          height: 131.r,
          decoration: BoxDecoration(
            color: const Color(0xFF171822),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4.r),
            ),
            child: Column(
              children: [
                Container(
                  width: 103.r,
                  height: 100.r,
                  color: const Color(0xFF3692FD).withOpacity(0.1),
                  child: _buildImage(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      opened ? player.lastName : '?',
                      style: TextStyleHelper.helper9.copyWith(
                        fontWeight: FontWeight.w500,
                        color: opened ? null : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF393B55).withOpacity(0.5),
              width: 1.r,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (opened) {
      return Image.asset(
        player.asset,
        fit: BoxFit.cover,
      );
    }
    return Center(
      child: SizedBox(
        width: 40.r,
        height: 40.r,
        child: Image.asset(
          'assets/png/Profile.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
