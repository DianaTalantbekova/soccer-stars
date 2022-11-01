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
  final int coins;
  final bool selectHintActivated;
  final DateTime lastUpdated;

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
        coins: 30,
        selectHintActivated: false,
        lastUpdated: DateTime.now(),
      );

  bool get hasLetterInWord => word.any((element) => element.id != -1);

  bool get hasRandomHints => randomHint > 0;

  bool get hasSelectHints => selectHint > 0;

  bool get hasWordHints => wordHint > 0;

  bool get canTake =>
      DateTime.now().day != lastUpdated.day ||
      DateTime.now().year != lastUpdated.year ||
      DateTime.now().month != lastUpdated.month;

  const QuizState({
    required this.appState,
    required this.level,
    required this.player,
    required this.word,
    required this.letters,
    required this.premium,
    required this.randomHint,
    required this.selectHint,
    required this.wordHint,
    required this.coins,
    required this.selectHintActivated,
    required this.lastUpdated,
  });

  QuizState copyWith({
    AppState? appState,
    int? level,
    Player? player,
    List<Character>? word,
    List<Character>? letters,
    bool? premium,
    int? randomHint,
    int? selectHint,
    int? wordHint,
    int? coins,
    bool? selectHintActivated,
    DateTime? lastUpdated,
  }) {
    return QuizState(
      appState: appState ?? this.appState,
      level: level ?? this.level,
      player: player ?? this.player,
      word: word ?? this.word,
      letters: letters ?? this.letters,
      premium: premium ?? this.premium,
      randomHint: randomHint ?? this.randomHint,
      selectHint: selectHint ?? this.selectHint,
      wordHint: wordHint ?? this.wordHint,
      coins: coins ?? this.coins,
      selectHintActivated: selectHintActivated ?? false,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
