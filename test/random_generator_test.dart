import 'dart:math';

import 'package:random_data/random_data.dart';
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

    test('Phone number', () {
      final gen = PhoneGen(random: Random(555));
      expect(gen.take(10), [
        '+72-6549909766',
        '+57-2689257867',
        '+37-0282318878',
        '+53-1228904441',
        '+06-8586502956',
        '+68-6898429600',
        '+23-4198016462',
        '+14-4760981752',
        '+77-1481430490',
        '+11-8129290059'
      ]);
    });
  });
}
