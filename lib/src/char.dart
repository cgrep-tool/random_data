part of 'base.dart';

class CharGen extends Generator<String> {
  final CharRanges ranges;

  IntGen _internal;

  CharGen(this.ranges, {Random random}) {
    _internal = IntGen(0, ranges.total - 1, random: random ?? Random());
  }

  factory CharGen.alpha({Random random}) {
    return CharGen(CharRanges.alpha(), random: random);
  }

  factory CharGen.numeric({Random random}) {
    return CharGen(CharRanges.numeric(), random: random);
  }

  factory CharGen.alphaNumeric({Random random}) {
    return CharGen(CharRanges.alphaNumeric(), random: random);
  }

  factory CharGen.alphaLow({Random random}) {
    return CharGen(CharRanges.alphaLow(), random: random);
  }

  factory CharGen.alphaHigh({Random random}) {
    return CharGen(CharRanges.alphaHigh(), random: random);
  }

  @override
  String next() {
    int index = _internal.next();

    int curIndex = 0;
    for (IntRange range in ranges.ranges) {
      if (index < (curIndex + range.length)) {
        return String.fromCharCode(range.min + (index - curIndex));
      }
      curIndex += range.length;
    }

    throw Exception("Index out of range");
  }

  @override
  bool get isMinLessThanEqualMax => true;

  @override
  String get type => "String";
}

class CharRanges {
  final List<IntRange> ranges;

  int _total;

  int get total => _total;

  CharRanges(this.ranges) {
    _total = ranges.fold(0, (int p, r) => p + r.length);
  }

  factory CharRanges.alpha() {
    return CharRanges([IntRange(65, 90), IntRange(97, 122)]);
  }

  factory CharRanges.numeric() {
    return CharRanges([IntRange(48, 57)]);
  }

  factory CharRanges.alphaNumeric() {
    return CharRanges([IntRange(65, 90), IntRange(97, 122), IntRange(48, 57)]);
  }

  factory CharRanges.alphaLow() {
    return CharRanges([IntRange(97, 122)]);
  }

  factory CharRanges.alphaHigh() {
    return CharRanges([IntRange(65, 90)]);
  }

  static CharRanges fromSpec(String spec) {
    final parts = spec.split(',');

    final ranges = <IntRange>[];

    for (String part in parts) {
      final ends = part.split(':');

      if (ends.length > 2) {
        throw FormatException("Invalid range!");
      }

      if (ends.length == 1) {
        final end = unescapeChar(ends.first);
        ranges.add(IntRange(end, end));
      }

      final start = unescapeChar(ends.first);
      final end = unescapeChar(ends[1]);

      if (start > end) {
        throw FormatException("Start cannot be greater than end!");
      }

      ranges.add(IntRange(start, end));
    }

    return CharRanges(ranges);
  }
}

class Range<T> {
  final T min;

  final T max;

  Range(this.min, this.max);
}

class IntRange implements Range<int> {
  final int min;

  final int max;

  IntRange(this.min, this.max);

  int get length => max - min + 1;
}
