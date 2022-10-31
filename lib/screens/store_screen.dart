import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/card_button.dart';
import 'package:soccer_stars/widgets/hint_button.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

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

  Widget _buildBody({int? coin}) {
    return Column(
      children: [
        const AppBarWidget(
          coins: 30,
          currentPlayer: 1,
          totalPlayers: 80,
        ),
        SizedBox(height: 20.h),
        _buildCard(
          asset: '?',
          title: 'random',
          count: 5,
          description: 'Opens random letter',
          buttonText: '$coin coins',
        ),
        SizedBox(height: 16.h),
        _buildCard(
          asset: 'assets/png/pencil.png',
          title: 'choose',
          description: 'Opens selected letter',
          buttonText: '$coin coins',
        ),
        SizedBox(height: 16.h),
        _buildCard(
          asset: 'aA',
          title: 'whole word',
          description: 'Opens whole word',
          buttonText: '$coin coins',
        ),
      ],
    );
  }

  Widget _buildCard({
    required String asset,
    required String title,
    required String description,
    required String buttonText,
    int count = 0,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: 343.r,
      height: 80.r,
      decoration: BoxDecoration(
        color: ThemeHelper.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: ThemeHelper.lightBlue.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          HintButton(asset: asset),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title.toUpperCase(),
                      style: TextStyleHelper.helper7,
                    ),
                    if (count != 0)
                      TextSpan(
                          text: " — ${count.toString()}",
                          style: TextStyleHelper.helper7
                              .copyWith(color: ThemeHelper.lightBlue)),
                  ],
                ),
              ),
              Text(
                description,
                style: TextStyleHelper.helper2,
              ),
            ],
          ),
          const Spacer(),
          CardButton(
            buttonText: buttonText,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
