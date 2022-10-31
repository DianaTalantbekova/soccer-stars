import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._();
  late final SharedPreferences _preferences;

  PreferenceService._();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  factory PreferenceService() => _instance;

  static const _levelKey = "LEVEL_KEY";
  static const _premiumKey = "PREMIUM_KEY";
  static const _randomHintKey = "RANDOM_HINT_KEY";
  static const _selectHintKey = "SELECT_HINT_KEY";
  static const _wordHintKey = "WORD_HINT_KEY";
  static const _wordKey = "WORD_KEY";
  static const _lettersKey = "LETTERS_KEY";

  Future<void> saveLevel(int value) async {
    await _preferences.setInt(_levelKey, value);
  }

  int getLevel() {
   return _preferences.getInt(_levelKey) ?? 0;
  }

  Future<void> setPremium() async {
    await _preferences.setBool(_premiumKey, true);
  }

  bool getPremium() {
    return _preferences.getBool(_premiumKey) ?? false;
  }

  Future<void> setRandomHint(int value) async {
    await _preferences.setInt(_randomHintKey, value);
  }

  int getRandomHint() {
    return _preferences.getInt(_randomHintKey) ?? 1;
  }

  Future<void> setSelectHint(int value) async {
    await _preferences.setInt(_selectHintKey, value);
  }

  int getSelectHint() {
    return _preferences.getInt(_selectHintKey) ?? 1;
  }

  Future<void> setWordHint(int value) async {
    await _preferences.setInt(_wordHintKey, value);
  }

  int getWordHint() {
    return _preferences.getInt(_wordHintKey) ?? 1;
  }

  Future<void> setWord(List<String> list) async {
    await _preferences.setStringList(_wordKey, list);
  }

  List<String> getWord(){
    return _preferences.getStringList(_wordKey) ?? [];
  }

  Future<void> setLetters(List<String> value) async {
    await _preferences.setStringList(_lettersKey, value);
  }

  List<String> getLetters() {
    return _preferences.getStringList(_lettersKey) ?? [];
  }
}