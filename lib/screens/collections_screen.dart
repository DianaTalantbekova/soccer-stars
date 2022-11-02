import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/blocs/blocs.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/utils/players.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/custom_avatar_widget.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

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
        return Column(
          children: [
            AppBarWidget(
              coins: state.coins,
              currentPlayer: level,
              totalPlayers: 80,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 80,
                padding: EdgeInsets.symmetric(
                  horizontal: 17.w,
                  vertical: 20.h,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.r,
                  mainAxisSpacing: 16.r,
                  childAspectRatio: 103 / 131,
                ),
                itemBuilder: (context, index) {
                  return CustomAvatarWidget(
                    opened: index < level,
                    player: players[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
