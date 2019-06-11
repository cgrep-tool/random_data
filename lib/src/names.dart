part of 'base.dart';

class NameGen extends Generator<String> {
  OneOfGen _first;

  OneOfGen _last;

  NameGen._(this._first, this._last);

  factory NameGen({Random random}) {
    return NameGen._(
        OneOfGen.firstName(random: random), OneOfGen.lastName(random: random));
  }

  factory NameGen.from(List<String> firstNames, List<String> lastNames,
      {Random random}) {
    return NameGen._(OneOfGen(firstNames, random: random),
        OneOfGen(lastNames, random: random));
  }

  String next() {
    return _first.next() + ' ' + _last.next();
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}
