import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/blocs/blocs.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/premium_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final bonus = 50;

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
          Positioned.fill(
            child: SafeArea(
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final level = state.level;
        final premium = state.premium;
        return Column(
          children: [
            AppBarWidget(
              coins: state.coins,
              currentPlayer: level,
              totalPlayers: 80,
            ),
            SizedBox(height: 20.h),
            PremiumButton(
              text: !premium ? 'Get premium for 0.99\$' : 'get $bonus coins',
              onTap: premium
                  ? state.canTake
                      ? () => _getMoney(context, bonus)
                      : null
                  : () => _getPremium(context),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSettingsButton(
                  onTap: () => _launchUrl(
                      'https://docs.google.com/document/d/1LX6b5dORlzysVeeiVk3WJjPpMHIxssi3C4XLTRgjSiE/edit?usp=sharing'),
                  asset: 'assets/png/privacy_policy.png',
                  text: 'privacy\npolicy',
                ),
                SizedBox(width: 16.w),
                _buildSettingsButton(
                  onTap: () => _launchUrl(
                      'https://docs.google.com/document/d/1VBJiNRrRuddf2NsFh4KhnJ1HnAd6HhuIfHUS69rL02M/edit?usp=sharing'),
                  asset: 'assets/png/terms_of_use.png',
                  text: 'terms\nof use',
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildSettingsButton(
              onTap: () => _launchUrl(
                  'https://docs.google.com/forms/d/e/1FAIpQLSftNcEx2tmzCKe9w2Ul_QQqAP35ulK4e65OfgUxxC35EjxIeg/viewform?usp=sf_link'),
              asset: 'assets/png/support.png',
              text: 'support',
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsButton({
    required String asset,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 20.r),
        width: 163.5.w,
        height: 72.h,
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

  void _getMoney(BuildContext context, bonus) {
    context.read<QuizBloc>().add(GetMoneyQuizEvent(bonus));
  }

  void _getPremium(BuildContext context) {
    context.go('/premium_screen');
  }

  Future<void> _launchUrl(String link) async {
    if (!await launchUrlString(link)) {
      throw 'Could not launch $link';
    }
  }
}
