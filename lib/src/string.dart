part of 'base.dart';

class StringGen extends Generator<String> {
  IntGen _internal;

  CharGen _charGen;

  CharGen _prefixGen;

  StringGen(CharRanges ranges, int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    random ??= Random();

    if (minLength == null) minLength = 1;
    if (maxLength == null) maxLength = minLength + 5;

    _internal = IntGen(minLength, maxLength, random: random);
    _charGen = CharGen(ranges, random: random);
    _prefixGen = prefix;
  }

  factory StringGen.alpha(int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    return StringGen(CharRanges.alpha(), minLength, maxLength,
        random: random, prefix: prefix);
  }

  factory StringGen.numeric(int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    return StringGen(CharRanges.numeric(), minLength, maxLength,
        random: random, prefix: prefix);
  }

  factory StringGen.alphaNumeric(int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    return StringGen(CharRanges.alphaNumeric(), minLength, maxLength,
        random: random, prefix: prefix);
  }

  factory StringGen.alphaLow(int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    return StringGen(CharRanges.alphaLow(), minLength, maxLength,
        random: random, prefix: prefix);
  }

  factory StringGen.alphaHigh(int minLength, int maxLength,
      {Random random, CharGen prefix}) {
    return StringGen(CharRanges.alphaHigh(), minLength, maxLength,
        random: random, prefix: prefix);
  }

  @override
  String next() {
    String prefix = '';
    if (_prefixGen != null) prefix = _prefixGen.next();
    int length = _internal.next();
    String suffix = _charGen.take(length - (_prefixGen != null ? 1 : 0)).join();
    return prefix + suffix;
  }

  @override
  bool get isMinLessThanEqualMax => _internal.isMinLessThanEqualMax;

  @override
  String get type => 'String';
}
