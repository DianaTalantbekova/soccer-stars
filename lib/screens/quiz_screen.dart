import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56.r,
              child: Row(
                children: [
                  SizedBox(
                    width: 56.r,
                    height: 56.r,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text("50 coins"),
                    ),
                  ),
                  SizedBox(
                    width: 56.r,
                    height: 56.r,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
