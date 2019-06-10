part of 'base.dart';

class CharSel {
  final List<IntRange> ranges;

  int _total;

  int get total => _total;

  CharSel(this.ranges) {
    _total = ranges.fold(0, (int p, r) => p + r.length);
  }

  static CharSel fromSpec(String spec) {
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

    return CharSel(ranges);
  }
}

class CharGen implements Generator<String> {
  final CharSel sel;

  IntGen _internal;

  CharGen(this.sel, Random random) {
    _internal = IntGen(0, sel.total, random);
  }

  @override
  String next() {
    int index = _internal.next();

    int curIndex = 0;
    for (IntRange range in sel.ranges) {
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