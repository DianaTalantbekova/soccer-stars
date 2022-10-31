import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/premium_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.darkBlue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/png/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const AppBarWidget(
          coins: 40,
          currentPlayer: 2,
          totalPlayers: 80,
        ),
        SizedBox(height: 20.h),
        const PremiumButton(text: 'Get premium for 0.99\$'),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSettingsButton(
              asset: 'assets/png/privacy_policy.png',
              text: 'privacy\npolicy',
            ),
            SizedBox(width: 16.w),
            _buildSettingsButton(
              asset: 'assets/png/terms_of_use.png',
              text: 'terms\nof use',
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildSettingsButton(
          asset: 'assets/png/support.png',
          text: 'support',
        ),
      ],
    );
  }

  Widget _buildSettingsButton({
    required String asset,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 20.r),
        width: 163.5.r,
        height: 72.r,
        decoration: BoxDecoration(
          color: ThemeHelper.darkBlue,
          border: Border.all(
            color: ThemeHelper.lightBlue.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 34.r,
              height: 34.r,
            ),
            SizedBox(width: 12.w),
            Text(
              text.toUpperCase(),
              style: TextStyleHelper.helper10,
            )
          ],
        ),
      ),
    );
  }
}
