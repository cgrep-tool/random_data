part of 'base.dart';

class DateTimeGen extends Generator<DateTime> {
  final DateTime min;

  final DateTime max;

  IntGen _internal;

  DateTimeGen(this.min, this.max, {Random random}) {
    _internal = IntGen(min.microsecondsSinceEpoch, max.microsecondsSinceEpoch,
        random: random ?? Random());
  }

  DateTime next() {
    if (max == min) return min;
    return DateTime.fromMicrosecondsSinceEpoch(_internal.next(), isUtc: true);
  }

  @override
  String get type => 'Date';

  @override
  bool get isMinLessThanEqualMax {
    return min.microsecondsSinceEpoch <= max.microsecondsSinceEpoch;
  }
}
