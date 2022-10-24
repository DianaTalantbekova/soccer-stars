import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171822),
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
              onTap: _onTap,
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
        Container(
          width: 343.w,
          height: 72.h,
          color: Colors.green,
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextButton(),
            _buildTextButton(),
            _buildTextButton(),
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

  Widget _buildTextButton() {
    return SizedBox(
      height: 40.h,
      width: 114.w,
      child: const Center(
        child: Text(
          "data",
          style: TextStyle(color: Colors.white),
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
          color: const Color(0xFF171822).withOpacity(0.94),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: const Color(0xFF3692FD),
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
              style: TextStyle(
                fontSize: 14.sp,
                height: 17 / 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {}
}
