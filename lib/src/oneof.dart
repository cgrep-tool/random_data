part of 'base.dart';

class OneOfGen extends Generator<dynamic> {
  final List<dynamic> options;

  IntGen _internal;

  OneOfGen(this.options, {Random random}) {
    _internal = IntGen(0, options.length - 1, random: random ?? Random());
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
