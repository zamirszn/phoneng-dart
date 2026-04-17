import 'package:phone_ng/src/prefixes.dart';

String toE164(String national10) {
  return "+$countryCode$national10";
}

String toNational(String national10) {
  return "$trunkPrefix$national10";
}

String toInternational(String national10) {
  if (national10.length != 10) return national10;

  final String part1 = national10.substring(0, 3);
  final String part2 = national10.substring(3, 6);
  final String part3 = national10.substring(6);

  return "+$countryCode $part1 $part2 $part3";
}

String toCompact(String national10) {
  return "$countryCode$national10";
}

String toRFC3966(String national10) {
  return "$rfc3966Prefix$countryCode$national10";
}
