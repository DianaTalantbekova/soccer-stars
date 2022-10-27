import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/hint_button.dart';
import 'package:soccer_stars/widgets/letter_button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.backgroundColor,
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
          coins: 30,
          currentPlayer: 1,
          totalPlayers: 80,
        ),
        SizedBox(height: 20.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: SizedBox(
            width: 295.r,
            height: 295.r,
            child: Image.asset('assets/png/pele.png'),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLetterArea(),
            SizedBox(width: 8.w),
            _buildLetterArea(),
            SizedBox(width: 8.w),
            _buildLetterArea(),
            SizedBox(width: 8.w),
            _buildLetterArea(),
          ],
        ),
        SizedBox(height: 71.h),
        _buildHints(),
        SizedBox(height: 8.h),
        _buildGridView(),
      ],
    );
  }

  Widget _buildHints() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          const HintButton(
            asset: '?',
          ),
          SizedBox(width: 8.w),
          const HintButton(
            asset: 'assets/png/pencil.png',
          ),
          SizedBox(width: 8.w),
          const HintButton(
            asset: 'aA',
          ),
          const Spacer(),
          const HintButton(
            asset: 'assets/png/backspace.png',
            color: ThemeHelper.red50,
          ),
        ],
      ),
    );
  }

  Widget _buildLetterArea() {
    return const LetterButton();
  }

  Widget _buildGridView() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: 50.5.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: ThemeHelper.backgroundColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: ThemeHelper.border),
            ),
            child: Text(
              'A',
              style: TextStyleHelper.helper8,
            ),
          );
        },
      ),
    );
  }
}
