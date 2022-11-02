import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/blocs/blocs.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/card_button.dart';
import 'package:soccer_stars/widgets/hint_button.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  final randomCost = 10;
  final selectCost = 15;
  final wordCost = 50;

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
        final coins = state.coins;
        final hasMoneyForRandomHint = coins >= randomCost;
        final hasMoneyForSelectHint = coins >= selectCost;
        final hasMoneyForWordHint = coins >= wordCost;
        return Column(
          children: [
            AppBarWidget(
              coins: coins,
              currentPlayer: state.level,
              totalPlayers: 80,
            ),
            SizedBox(height: 20.h),
            _buildCard(
              asset: '?',
              title: 'random',
              count: state.randomHint,
              description: 'Opens random letter',
              buttonText: '$randomCost coins',
              onTap: hasMoneyForRandomHint
                  ? () => context
                      .read<QuizBloc>()
                      .add(BuyRandomHintQuizEvent(randomCost))
                  : null,
            ),
            SizedBox(height: 16.h),
            _buildCard(
              count: state.selectHint,
              asset: 'assets/png/pencil.png',
              title: 'choose',
              description: 'Opens selected letter',
              buttonText: '$selectCost coins',
              onTap: hasMoneyForSelectHint
                  ? () => context
                      .read<QuizBloc>()
                      .add(BuySelectHintQuizEvent(selectCost))
                  : null,
            ),
            SizedBox(height: 16.h),
            _buildCard(
              count: state.wordHint,
              asset: 'aA',
              title: 'whole word',
              description: 'Opens whole word',
              buttonText: '$wordCost coins',
              onTap: hasMoneyForWordHint
                  ? () => context
                      .read<QuizBloc>()
                      .add(BuyWordHintQuizEvent(wordCost))
                  : null,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard({
    required String asset,
    required String title,
    required String description,
    required String buttonText,
    int count = 0,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: 343.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: ThemeHelper.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: ThemeHelper.lightBlue.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            HintButton(
              asset: asset,
              onTap: () {},
            ),
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
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
