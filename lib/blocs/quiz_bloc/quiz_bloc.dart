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
    on<NextQuizEvent>(_onNext);
    on<SelectLetterQuizEvent>(_onSelectLetter);
    on<UnselectLetterQuizEvent>(_onUnselectLetter);
  }

  FutureOr<void> _onNext(
    NextQuizEvent event,
    Emitter<QuizState> emit,
  ) {}

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
      ),
    );
  }

  QuizState _generateLevel(Player player) {
    final player = state.player;
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
      letters.add(Character(id: id, char: letter, fromHint: false));
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
    final index = word.indexWhere((e) => e.id == emptyCharacter.id);
    if (index == -1) return;

    final letters = state.letters;

    word[index] = character;
    letters[character.id] = emptyCharacter;

    final hasCeil = word.contains(emptyCharacter);

    if (hasCeil) {
      return emit(state.copyWith(
        word: word,
        letters: letters,
      ));
    }

    final quizWord = word.map((e) => e.char).join();
    if (quizWord != state.player.lastName) {
      return emit(state.copyWith(
        word: word,
        letters: letters,
      ));
    }

    final level = state.level + 1;
    final player = players[level];

    emit(state.copyWith(
      level: level,
      player: player,
    ));
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
  }
}
