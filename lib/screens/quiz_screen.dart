import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_stars/blocs/blocs.dart';
import 'package:soccer_stars/commons/theme_helper.dart';
import 'package:soccer_stars/models/character.dart';
import 'package:soccer_stars/widgets/app_bar_widget.dart';
import 'package:soccer_stars/widgets/hint_button.dart';
import 'package:soccer_stars/widgets/input_letter_button.dart';
import 'package:soccer_stars/widgets/letter_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizBloc _quizBloc;

  @override
  void initState() {
    _quizBloc = BlocProvider.of(context);
    super.initState();
  }

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
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final word = state.word;
        final length = word.length;
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
              children: List.generate(
                length,
                (index) {
                  return Row(
                    children: [
                      InputLetterButton(
                        onTap: () => _onUnselect(word[index], index),
                        character: word[index],
                      ),
                      if (index != length - 1) SizedBox(width: 8.w),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 71.h),
            _buildHints(),
            SizedBox(height: 8.h),
            _buildGridView(state.letters),
          ],
        );
      },
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
          HintButton(
            asset: 'assets/png/backspace.png',
            color: ThemeHelper.red.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Character> letters) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemBuilder: (context, index) {
          return LetterButton(
            onTap: () => _onSelect(letters[index]),
            character: letters[index],
          );
        },
      ),
    );
  }

  void _onUnselect(Character character, int index) {
    _quizBloc.add(UnselectLetterQuizEvent(character, index));
  }

  void _onSelect(Character character) {
    _quizBloc.add(SelectLetterQuizEvent(character));
  }
}
