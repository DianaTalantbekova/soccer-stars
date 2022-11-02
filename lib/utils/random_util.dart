import 'dart:math';

const _alphabet = "abcdefghiklmnopqrstuvwxyz";

String randomString(int n) {
  const length = _alphabet.length;
  String string = "";
  for (int i = 0; i < n; i++) {
    string += _alphabet[Random().nextInt(length)];
  }
  return string;
}
