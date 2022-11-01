part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class _NextQuizEvent extends QuizEvent {}

class InitQuizEvent extends QuizEvent {}

class SelectLetterQuizEvent extends QuizEvent {
  final Character character;
  final int? index;

  SelectLetterQuizEvent({required this.character, this.index});
}

class UnselectLetterQuizEvent extends QuizEvent {
  final Character character;
  final int index;

  UnselectLetterQuizEvent(this.character, this.index);
}

class RemoveLetterQuizEvent extends QuizEvent {}

class OpenRandomLetterQuizEvent extends QuizEvent {}

class SelectLetterHintQuizEvent extends QuizEvent {}

class OpenSelectedLetterQuizEvent extends QuizEvent {
  final int index;

  OpenSelectedLetterQuizEvent(this.index);
}

class OpenAllLettersQuizEvent extends QuizEvent {}
