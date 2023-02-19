import 'package:flutter_test/flutter_test.dart';
import 'package:nengar/extension/RegExpExtension.dart';

void main() {
  group('isSixDigitsNumber', () {
    test('hasMatch', () {
      expect('123456'.isSixDigitsNumber(), true);
      expect('1234567'.isSixDigitsNumber(), false);
      expect('12345'.isSixDigitsNumber(), false);
      expect('a12345'.isSixDigitsNumber(), false);
      expect('A12345'.isSixDigitsNumber(), false);
      expect('12345a'.isSixDigitsNumber(), false);
      expect('12345A'.isSixDigitsNumber(), false);
      expect('A123456'.isSixDigitsNumber(), false);
      expect('a123456'.isSixDigitsNumber(), false);
      expect('123456A'.isSixDigitsNumber(), false);
      expect('123456a'.isSixDigitsNumber(), false);
    });
  });

  group('isFourDigitsNumber', () {
    test('hasMatch', () {
      expect('1234'.isFourDigitsNumber(), true);
      expect('12345'.isFourDigitsNumber(), false);
      expect('123'.isFourDigitsNumber(), false);
      expect('a123'.isFourDigitsNumber(), false);
      expect('A123'.isFourDigitsNumber(), false);
      expect('123a'.isFourDigitsNumber(), false);
      expect('123A'.isFourDigitsNumber(), false);
      expect('A12345'.isFourDigitsNumber(), false);
      expect('a12345'.isFourDigitsNumber(), false);
      expect('12345A'.isFourDigitsNumber(), false);
      expect('12345a'.isFourDigitsNumber(), false);
    });
  });

  group('isTwoDigitsNumber', () {
    test('hasMatch', () {
      expect('12'.isTwoDigitsNumber(), true);
      expect('123'.isTwoDigitsNumber(), false);
      expect('1'.isTwoDigitsNumber(), false);
      expect('a1'.isTwoDigitsNumber(), false);
      expect('A1'.isTwoDigitsNumber(), false);
      expect('1a'.isTwoDigitsNumber(), false);
      expect('1A'.isTwoDigitsNumber(), false);
      expect('A12'.isTwoDigitsNumber(), false);
      expect('a12'.isTwoDigitsNumber(), false);
      expect('12A'.isTwoDigitsNumber(), false);
      expect('12a'.isTwoDigitsNumber(), false);
    });
  });
}
