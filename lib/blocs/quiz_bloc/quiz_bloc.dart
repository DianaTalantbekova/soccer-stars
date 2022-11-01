import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_stars/models/models.dart';
import 'package:soccer_stars/services/preference_service.dart';
import 'package:soccer_stars/utils/players.dart';
import 'package:soccer_stars/utils/random_util.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final PreferenceService _preferenceService;

  QuizBloc(this._preferenceService) : super(QuizState.loading()) {
    on<InitQuizEvent>(_onInit);
    on<_NextQuizEvent>(_onNext);
    on<SelectLetterQuizEvent>(_onSelectLetter);
    on<UnselectLetterQuizEvent>(_onUnselectLetter);
    on<RemoveLetterQuizEvent>(_onRemoveLetter);
    on<OpenRandomLetterQuizEvent>(_onOpenRandomLetter);
    on<SelectLetterHintQuizEvent>(_onSelectLetterHint);
    on<OpenSelectedLetterQuizEvent>(_onOpenSelectedLetter);
    on<OpenAllLettersQuizEvent>(_onOpenAllLetter);
    on<BuyRandomHintQuizEvent>(_onBuyRandomHint);
    on<BuySelectHintQuizEvent>(_onBuySelectHint);
    on<BuyWordHintQuizEvent>(_onBuyWordHint);
    on<BuyPremiumQuizEvent>(_onBuyPremium);
    on<GetMoneyQuizEvent>(_onGetMoney);
  }

  FutureOr<void> _onNext(
    _NextQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    final newState = _generateLevel(state.player);
    final word = newState.word;
    final wordData = word.map((e) => jsonEncode(e.toMap())).toList();
    _preferenceService.setWord(wordData);
    final letters = newState.letters;
    final lettersData = letters.map((e) => jsonEncode(e.toMap())).toList();
    _preferenceService.setLetters(lettersData);
    _preferenceService.setLevel(newState.level);
    _preferenceService.setCoins(newState.coins);
    emit(newState);
  }

  FutureOr<void> _onInit(
    InitQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    final level = _preferenceService.getLevel();
    final player = players[level];
    final premium = _preferenceService.getPremium();
    final randomHint = _preferenceService.getRandomHint();
    final selectHint = _preferenceService.getSelectHint();
    final wordHint = _preferenceService.getWordHint();
    final wordData = _preferenceService.getWord();
    final lettersData = _preferenceService.getLetters();
    final dateTimeData = _preferenceService.getLastUpdated();
    final coins = _preferenceService.getCoins();

    final lastUpdated = DateTime.parse(dateTimeData);

    final newState = _generateLevel(player);

    final word = newState.word;
    final letters = newState.letters;

    if (wordData.isNotEmpty) {
      word.clear();
      for (final item in wordData) {
        final character = Character.fromMap(jsonDecode(item));
        word.add(character);
      }
    }

    if (lettersData.isNotEmpty) {
      letters.clear();
      for (final item in lettersData) {
        final character = Character.fromMap(jsonDecode(item));
        letters.add(character);
      }
    }

    emit(
      QuizState(
        level: level,
        player: player,
        word: word,
        letters: letters,
        premium: premium,
        randomHint: randomHint,
        selectHint: selectHint,
        wordHint: wordHint,
        appState: AppState.idle,
        coins: coins,
        selectHintActivated: false,
        lastUpdated: lastUpdated,
      ),
    );
  }

  QuizState _generateLevel(Player player) {
    final length = player.lastName.length;
    final tempLetters = player.lastName.split('');

    const int maxLetters = 12;

    if (length < maxLetters) {
      tempLetters.addAll(randomString(maxLetters - length).split(''));
    }

    final List<Character> word = [
      for (int i = 0; i < length; i++) Character.empty()
    ];

    final List<Character> letters = [];

    while (letters.length < maxLetters) {
      final id = letters.length;
      final letter = tempLetters[Random().nextInt(tempLetters.length)];
      tempLetters.remove(letter);
      letters.add(Character(
        id: id,
        char: letter.toUpperCase(),
        fromHint: false,
      ));
    }

    return state.copyWith(
      word: word,
      letters: letters,
    );
  }

  FutureOr<void> _onSelectLetter(
    SelectLetterQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final character = event.character;
    final emptyCharacter = Character.empty();
    if (character.id == emptyCharacter.id) return;

    final word = state.word;
    final index =
        event.index ?? word.indexWhere((e) => e.id == emptyCharacter.id);
    if (index == -1) return;

    final letters = state.letters;

    word[index] = character;
    letters[character.id] = emptyCharacter;

    final hasCeil = word.contains(emptyCharacter);

    if (hasCeil) {
      final wordData = word.map((e) => jsonEncode(e.toMap())).toList();
      _preferenceService.setWord(wordData);
      final lettersData = letters.map((e) => jsonEncode(e.toMap())).toList();
      _preferenceService.setLetters(lettersData);

      return emit(state.copyWith(
        word: word,
        letters: letters,
      ));
    }

    emit(state.copyWith(
      word: word,
      letters: letters,
    ));

    final quizWord = word.map((e) => e.char).join();
    if (quizWord != state.player.lastName.toUpperCase()) return;

    final level = state.level + 1;
    final player = players[level];
    final coins = state.coins + 20;

    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      level: level,
      player: player,
      coins: coins,
    ));

    add(_NextQuizEvent());
  }

  FutureOr<void> _onUnselectLetter(
    UnselectLetterQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final character = event.character;
    final emptyCharacter = Character.empty();
    if (character.fromHint || emptyCharacter.id == character.id) return;

    final word = state.word;
    final letters = state.letters;

    word[event.index] = emptyCharacter;
    letters[character.id] = character;
    emit(state.copyWith(
      word: word,
      letters: letters,
    ));
    if(!event.silent) {
      final wordData = word.map((e) => jsonEncode(e.toMap())).toList();
      _preferenceService.setWord(wordData);
      final lettersData = letters.map((e) => jsonEncode(e.toMap())).toList();
      _preferenceService.setLetters(lettersData);
    }
  }

  FutureOr<void> _onRemoveLetter(
    RemoveLetterQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final word = state.word;

    final emptyCharacter = Character.empty();
    final index = word.lastIndexWhere(
        (element) => element.id != emptyCharacter.id && !element.fromHint);

    if (index == -1) return;

    final letters = state.letters;
    final character = word[index];

    word[index] = emptyCharacter;
    letters[character.id] = character;

    emit(state.copyWith(
      word: word,
      letters: letters,
    ));
  }

  FutureOr<void> _onOpenRandomLetter(
    OpenRandomLetterQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final randomHint = state.randomHint - 1;
    final word = state.word;
    final emptyCharacter = Character.empty();

    final correctWord = state.player.lastName.split('');
    final List<int> indexes = [];
    for (int i = 0; i < correctWord.length; i++) {
      if (correctWord[i].toUpperCase() != word[i].char.toUpperCase() &&
          !word[i].fromHint) {
        indexes.add(i);
      }
    }

    if (indexes.isEmpty) return;

    final subIndex = Random().nextInt(indexes.length);
    final index = indexes[subIndex];
    final tempCharacter = word[index];
    final targetLetter = correctWord[index];

    final letters = state.letters;
    final character = letters.firstWhere(
      (element) => element.char.toUpperCase() == targetLetter.toUpperCase(),
      orElse: () => emptyCharacter,
    );

    if (character == emptyCharacter) return;

    emit(state.copyWith(randomHint: randomHint));

    add(UnselectLetterQuizEvent(tempCharacter, index, silent: true));

    add(SelectLetterQuizEvent(
      character: character.copyWith(fromHint: true),
      index: index,
    ));

    _preferenceService.setRandomHint(randomHint);
  }

  FutureOr<void> _onSelectLetterHint(
    SelectLetterHintQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    emit(state.copyWith(selectHintActivated: true));
  }

  FutureOr<void> _onOpenSelectedLetter(
    OpenSelectedLetterQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final index = event.index;
    final emptyCharacter = Character.empty();

    final word = state.word;
    final targetLetter = state.player.lastName[index].toUpperCase();

    final selectedWord = word[index];

    if (targetLetter == selectedWord.char) {
      return;
    }

    final selectHint = state.selectHint - 1;

    if (!event.silent) {
      emit(state.copyWith(selectHint: selectHint));
      _preferenceService.setSelectHint(selectHint);
    }

    add(UnselectLetterQuizEvent(selectedWord, index, silent: true));

    final letters = state.letters;

    final character = letters.firstWhere(
      (element) => element.char == targetLetter,
      orElse: () => emptyCharacter,
    );

    if (character != emptyCharacter) {
      return add(SelectLetterQuizEvent(
        character: character,
        index: index,
      ));
    }

    final newIndex = word.indexWhere((element) => element.char == targetLetter);

    if (newIndex == -1) return;

    final newCharacter = word[newIndex];

    add(UnselectLetterQuizEvent(newCharacter, newIndex, silent: true));

    add(SelectLetterQuizEvent(
      character: newCharacter,
      index: index,
    ));
  }

  FutureOr<void> _onOpenAllLetter(
    OpenAllLettersQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    final word = state.word;
    for (int i = 0; i < word.length; i++) {
      add(OpenSelectedLetterQuizEvent(index: i, silent: true));
    }

    final wordHint = state.wordHint - 1;
    emit(state.copyWith(wordHint: wordHint));
    _preferenceService.setWordHint(wordHint);
  }

  FutureOr<void> _onBuyRandomHint(
    BuyRandomHintQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final cost = event.cost;
    final coins = state.coins - cost;
    if (coins < 0) return;

    final randomHint = state.randomHint + 1;
    emit(state.copyWith(randomHint: randomHint, coins: coins));

    _preferenceService.setRandomHint(randomHint);
    _preferenceService.setCoins(coins);
  }

  FutureOr<void> _onBuySelectHint(
    BuySelectHintQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final cost = event.cost;
    final coins = state.coins - cost;
    if (coins < 0) return;

    final selectHint = state.selectHint + 1;
    emit(state.copyWith(selectHint: selectHint, coins: coins));
    _preferenceService.setSelectHint(selectHint);
    _preferenceService.setCoins(coins);
  }

  FutureOr<void> _onBuyWordHint(
    BuyWordHintQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    final cost = event.cost;
    final coins = state.coins - cost;
    if (coins < 0) return;

    final wordHint = state.wordHint + 1;
    emit(state.copyWith(wordHint: wordHint, coins: coins));
    _preferenceService.setWordHint(wordHint);
    _preferenceService.setCoins(coins);
  }

  FutureOr<void> _onBuyPremium(
    BuyPremiumQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    final lastUpdated = DateTime.now().subtract(const Duration(days: 1));
    emit(state.copyWith(
      premium: true,
      lastUpdated: lastUpdated,
    ));

    _preferenceService.setPremium();
  }

  FutureOr<void> _onGetMoney(
    GetMoneyQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    final coins = state.coins + event.bonus;
    emit(state.copyWith(
      coins: coins,
      lastUpdated: DateTime.now(),
    ));
    _preferenceService.setLastUpdated();
    _preferenceService.setCoins(coins);
  }
}