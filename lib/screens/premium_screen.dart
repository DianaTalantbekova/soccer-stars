import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/blocs/blocs.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/premium_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
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
        Padding(
          padding: EdgeInsets.only(
            right: 16.r,
            top: 16.r,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.go('/settings_screen'),
              child: SizedBox(
                width: 24.r,
                height: 24.r,
                child: Image.asset('assets/png/close.png'),
              ),
            ),
          ),
        ),
        SizedBox(height: 48.h),
        _buildInfo(),
        SizedBox(height: 136.h),
        PremiumButton(
          text: 'Get premium for 0.99\$',
          onTap: () => _onBuy(context),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextButton(
              text: 'Terms of Use',
              onTap: () => _launchUrl(
                  'https://docs.google.com/document/d/1VBJiNRrRuddf2NsFh4KhnJ1HnAd6HhuIfHUS69rL02M/edit?usp=sharing'),
            ),
            _buildTextButton(
              text: 'Restore',
              onTap: () => _onBuy(context),
            ),
            _buildTextButton(
              text: 'Privacy Policy',
              onTap: () => _launchUrl(
                  'https://docs.google.com/document/d/1LX6b5dORlzysVeeiVk3WJjPpMHIxssi3C4XLTRgjSiE/edit?usp=sharing'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildInfo() {
    return SizedBox(
      width: 375.w,
      height: 374.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/png/premium_text.png'),
          ),
          Positioned(
            top: 0,
            left: 8.w,
            right: 8.w,
            child: Image.asset('assets/png/player.png'),
          ),
          Positioned(
            left: 32.w,
            right: 32.w,
            bottom: 41.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  text: 'Remove \nADS',
                  asset: 'assets/png/slash.png',
                ),
                _buildButton(
                  text: 'Daily \nCOINS',
                  asset: 'assets/png/group.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton({required String text, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40.h,
        width: 114.w,
        child: Center(
          child: Text(
            text,
            style: TextStyleHelper.helper2,
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required String asset,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 147.w,
        height: 87.h,
        decoration: BoxDecoration(
          color: ThemeHelper.darkBlue.withOpacity(0.94),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: ThemeHelper.lightBlue,
            width: 0.5.r,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: Image.asset(asset),
            ),
            SizedBox(height: 5.h),
            Text(
              text,
              style: TextStyleHelper.helper3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  _onBuy(BuildContext context) {
    context.read<QuizBloc>().add(BuyPremiumQuizEvent());
    context.go('/settings_screen');
  }

  Future<void> _launchUrl(String link) async {
    if (!await launchUrlString(link)) {
      throw 'Could not launch $link';
    }
  }
}
