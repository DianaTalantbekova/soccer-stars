part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class NextQuizEvent extends QuizEvent {}

class InitQuizEvent extends QuizEvent {}

class SelectLetterQuizEvent extends QuizEvent {
  final Character character;

  SelectLetterQuizEvent(this.character);
}

class UnselectLetterQuizEvent extends QuizEvent {
  final Character character;
  final int index;

  UnselectLetterQuizEvent(this.character, this.index);
}