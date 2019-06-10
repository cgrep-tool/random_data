part of 'base.dart';

final int intMin = -pow(2, 63);

final int intMax = (-pow(2, 63)) - 1;

class IntGen extends Generator<int> {
  final int min;

  final int max;

  Random _random;

  IntGen._(this.min, this.max, this._random);

  factory IntGen(int min, int max, {Random random}) {
    return IntGen._(min ?? 0, max ?? pow(2, 32), random ?? Random());
  }

  int next() {
    if (max == min) return min;
    double diff = max.toDouble() - min.toDouble() + 1;
    if (diff <= pow(2, 32)) {
      return _random.nextInt(diff.toInt()) + min;
    }
    double d = _random.nextDouble();
    return ((d * diff) + min).toInt();
  }

  @override
  String get type => 'Int';

  @override
  bool get isMinLessThanEqualMax {
    return min <= max;
  }
}
