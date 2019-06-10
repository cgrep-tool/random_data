part of 'base.dart';

class DoubleGen implements Generator<double> {
  final double min;

  final double max;

  Random _random;

  DoubleGen._(this.min, this.max, this._random);

  factory DoubleGen(double min, double max, Random random) {
    return DoubleGen._(min ?? 0, max ?? pow(2, 32).toDouble(), random);
  }

  double next() {
    if (max == min) return min;
    return (_random.nextDouble() * (max - min)) + min;
  }

  @override
  String get type => 'Double';

  @override
  bool get isMinLessThanEqualMax {
    return min <= max;
  }
}