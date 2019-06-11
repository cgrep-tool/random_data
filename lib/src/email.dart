part of 'base.dart';

class DomainGen extends Generator<String> {
  Generator<String> _subdomain;

  OneOfGen _topLevelDomain;

  DomainGen({Random random}) {
    _subdomain = StringGen.alphaLow(5, 8, random: random);
    _topLevelDomain = OneOfGen.topLevelDomain(random: random);
  }

  DomainGen.familiar({Random random}) {
    _subdomain = OneOfGen<String>(_familiarSubDomains, random: random);
    _topLevelDomain = OneOfGen.topLevelDomain(random: random);
  }

  String next() {
    return _subdomain.next() + '.' + _topLevelDomain.next();
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}

class UrlGen extends Generator<String> {
  DomainGen _domain;

  StringGen _path;

  IntGen _pathLength;

  UrlGen(Random random) {
    _domain = DomainGen(random: random);
    _path = StringGen.alphaNumeric(5, 10, random: random);
    _pathLength = IntGen(1, 3, random: random);
  }

  String next() {
    int length = _pathLength.next();
    return 'https://${_domain.next()}/' + _path.take(length).join('/');
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}

class EmailGen extends Generator<Duration> {
  final Duration min;

  final Duration max;

  IntGen _internal;

  EmailGen(this.min, this.max, {Random random}) {
    _internal = IntGen(min.inMicroseconds, max.inMicroseconds,
        random: random ?? Random());
  }

  Duration next() {
    if (max == min) return min;
    return min + Duration(microseconds: _internal.next());
  }

  @override
  String get type => 'Duration';

  @override
  bool get isMinLessThanEqualMax {
    return min <= max;
  }
}

class PhoneGen extends Generator<String> {
  Generator<String> _country;

  Generator<String> _number;

  PhoneGen({Random random}) {
    _country = StringGen.numeric(2, 2, random: random);
    _number = StringGen.numeric(10, 10, random: random);
  }

  PhoneGen.withLength(int length, {Random random}) {
    _country = StringGen.numeric(2, 2, random: random);
    _number = StringGen.numeric(length, length, random: random);
  }

  String next() {
    return '+' + _country.next() + '-' + _number.next();
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}
