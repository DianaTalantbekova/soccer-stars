import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/commons/image_items.dart';
import 'package:soccer_stars/commons/text_style_helper.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/models/image_item.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key? key,
    required this.child,
    this.selected,
  }) : super(key: key);
  final Widget child;

  final int? selected;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selected = 0;

  @override
  void initState() {
    selected = widget.selected ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.darkBlue,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/png/background_image.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(child: widget.child),
                  _buildBottomNavigationBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 56.h,
      color: const Color(0xFF171822),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          imageItems.length,
          (index) {
            final item = imageItems[index];
            return _buildNavigationBarItem(
              imageItem: item,
              selected: index == selected,
              onTap: () {
                selected = index;
                context.go(item.path);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem({
    required ImageItem imageItem,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 93.w,
        height: 56.h,
        child: Center(
          child: selected
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: Image.asset(imageItem.assetOn),
                    ),
                    SizedBox(
                      height: 4.r,
                    ),
                    Text(
                      imageItem.name,
                      style: TextStyleHelper.helper9.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3692FD),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: Image.asset(imageItem.assetOff),
                ),
        ),
      ),
    );
  }
}
