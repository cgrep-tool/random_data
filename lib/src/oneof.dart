part of 'base.dart';

class OneOfGen implements Generator<dynamic> {
  final List<dynamic> options;

  IntGen _internal;

  OneOfGen(this.options, Random random) {
    _internal = IntGen(0, options.length - 1, random);
  }

  @override
  dynamic next() {
    return options[_internal.next()];
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}