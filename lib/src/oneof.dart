part of 'base.dart';

class OneOfGen<T> extends Generator<T> {
  final List<T> options;

  IntGen _internal;

  OneOfGen(this.options, {Random random}) {
    _internal = IntGen(0, options.length - 1, random: random ?? Random());
  }

  static OneOfGen<String> firstName({Random random}) {
    return OneOfGen<String>(faker.firstnames, random: random);
  }

  static OneOfGen<String> lastName({Random random}) {
    return OneOfGen(faker.lastnames, random: random);
  }

  static OneOfGen<String> topLevelDomain({Random random}) {
    return OneOfGen(_topLevelDomains, random: random);
  }

  static OneOfGen<String> familiarSubDomain({Random random}) {
    return OneOfGen(_familiarSubDomains, random: random);
  }

  static OneOfGen<String> country({Random random}) {
    return OneOfGen(faker.countries, random: random);
  }

  static OneOfGen<String> cities({Random random}) {
    return OneOfGen(_cities, random: random);
  }

  static OneOfGen<String> citiesWithCountries({Random random}) {
    return OneOfGen(_citiesWithCountries, random: random);
  }

  @override
  T next() {
    return options[_internal.next()];
  }

  @override
  String get type => 'String';

  @override
  bool get isMinLessThanEqualMax => true;
}

const _topLevelDomains = [
  'co.uk',
  'com',
  'org',
  'im',
  'dev',
  'us',
  'ca',
  'biz',
  'info',
  'name',
  'edu',
  'int',
  'net',
  'eu',
];

const _familiarSubDomains = [
  'google',
  'yahoo',
  'hotmail',
  'amazon',
  'microsoft',
  'uber',
  'aoezone',
  'zone',
  'example',
];
