import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

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
          coins: 40,
          currentPlayer: 2,
          totalPlayers: 80,
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: GridView.builder(
            itemCount: 20,
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 103.r,
                height: 131.r,
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeHelper.blue50),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(4.r),
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(4.r),
                      ),
                      child: Image.asset(
                        'assets/png/pele.png',
                        width: 103.r,
                        height: 100.r,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  // Widget _buildGuessedPlayer(){}
}
