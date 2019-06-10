part of 'base.dart';

class BoolGen implements Generator<bool> {
  Random _random;

  BoolGen(this._random);

  bool next() {
    return _random.nextBool();
  }

  @override
  String get type => 'Bool';

  @override
  bool get isMinLessThanEqualMax => true;
}
