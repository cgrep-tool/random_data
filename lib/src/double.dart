part of 'base.dart';

class DoubleGen extends Generator<double> {
  final double min;

  final double max;

  final int maxPrecision;

  Random _random;

  DoubleGen._(this.min, this.max, this.maxPrecision, this._random);

  factory DoubleGen(double min, double max, {Random random, int maxPrecision}) {
    return DoubleGen._(min ?? 0, max ?? pow(2, 32).toDouble(), maxPrecision,
        random ?? Random());
  }

  double next() {
    if (max == min) return min;
    final value = (_random.nextDouble() * (max - min)) + min;

    if (maxPrecision == null) return value;

    final str = value.toString();

    if (str.contains('e')) return value;

    final parts = str.split('.');

    if (parts[2].length <= maxPrecision) return value;

    return double.tryParse(
        parts[0] + '.' + parts[1].substring(0, maxPrecision));
  }

  @override
  String get type => 'Double';

  @override
  bool get isMinLessThanEqualMax {
    return min <= max;
  }
}
