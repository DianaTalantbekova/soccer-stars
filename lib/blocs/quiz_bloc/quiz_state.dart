part of 'quiz_bloc.dart';

enum AppState { idle, loading, success, error }

@immutable
class QuizState {
  final AppState appState;
  final int level;
  final Player player;
  final List<Character> word;
  final List<Character> letters;
  final bool premium;
  final int randomHint;
  final int selectHint;
  final int wordHint;

  factory QuizState.loading() => QuizState(
        level: 0,
        player: players[0],
        word: const [],
        letters: const [],
        premium: false,
        randomHint: 1,
        selectHint: 1,
        wordHint: 1,
        appState: AppState.loading,
      );

  const QuizState({
    required this.level,
    required this.player,
    required this.word,
    required this.letters,
    required this.premium,
    required this.randomHint,
    required this.selectHint,
    required this.wordHint,
    required this.appState,
  });

  QuizState copyWith({
    int? level,
    Player? player,
    List<Character>? word,
    List<Character>? letters,
    bool? premium,
    int? randomLetterHint,
    int? selectLetterHint,
    int? wordHint,
    AppState? appState,
  }) {
    return QuizState(
      level: level ?? this.level,
      player: player ?? this.player,
      word: word ?? this.word,
      letters: letters ?? this.letters,
      premium: premium ?? this.premium,
      randomHint: randomLetterHint ?? randomHint,
      selectHint: selectLetterHint ?? selectHint,
      wordHint: wordHint ?? this.wordHint,
      appState: appState ?? this.appState,
    );
  }
}
