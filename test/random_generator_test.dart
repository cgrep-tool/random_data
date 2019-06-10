import 'dart:math';

import 'package:random_generator/random_generator.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('CharGen', () {
      final gen = CharGen.alphaNumeric(random: Random(555));
      expect(gen.take(10), ['t', 'A', 's', 'D', 'a', 'L', 'L', 'Y', 'D', '5']);
    });

    test('StringGen', () {
      final gen = StringGen.alphaNumeric(1, 5, random: Random(555));
      expect(gen.take(10), [
        'AsD',
        'LLYD5',
        'qZ',
        'ose',
        'sH548',
        'NRS',
        'y2d',
        'mG',
        'AFZ',
        '6c'
      ]);
      final genWithPrefix = StringGen.alphaNumeric(1, 5,
          random: Random(555), prefix: CharGen.alpha(random: Random(555)));
      expect(genWithPrefix.take(10),
          ['tAs', 'O', 'oLLYD', 'b8q', 'q', 'Jos', 'JlsH', 'y48', 'LNR', 'b']);
    });
  });
}
