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
  final bool silent;

  UnselectLetterQuizEvent(this.character, this.index, {this.silent = false});
}

class RemoveLetterQuizEvent extends QuizEvent {}

class OpenRandomLetterQuizEvent extends QuizEvent {}

class SelectLetterHintQuizEvent extends QuizEvent {}

class OpenSelectedLetterQuizEvent extends QuizEvent {
  final int index;
  final bool silent;

  OpenSelectedLetterQuizEvent({required this.index, this.silent = false});
}

class OpenAllLettersQuizEvent extends QuizEvent {}

class BuyRandomHintQuizEvent extends QuizEvent {
  final int cost;

  BuyRandomHintQuizEvent(this.cost);
}

class BuySelectHintQuizEvent extends QuizEvent {
  final int cost;

  BuySelectHintQuizEvent(this.cost);
}

class BuyWordHintQuizEvent extends QuizEvent {
  final int cost;

  BuyWordHintQuizEvent(this.cost);
}

class BuyPremiumQuizEvent extends QuizEvent {}

class GetMoneyQuizEvent extends QuizEvent {
  final int bonus;

  GetMoneyQuizEvent(this.bonus);
}
