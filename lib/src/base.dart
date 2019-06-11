import 'dart:math';
import 'package:string_unescape/string_unescape.dart';
import 'package:faker/faker.dart' as faker;

part 'bool.dart';
part 'char.dart';
part 'cities.dart';
part 'date.dart';
part 'double.dart';
part 'duration.dart';
part 'email.dart';
part 'int.dart';
part 'names.dart';
part 'oneof.dart';
part 'string.dart';

abstract class Generator<T> {
  T next();

  List<T> take(int count) => List.generate(count, (i) => next());

  String get type;

  bool get isMinLessThanEqualMax;
}
