import 'package:phone_ng/src/models.dart';
import 'package:phone_ng/src/normalizer.dart';
import 'package:phone_ng/src/parser.dart';
import 'package:phone_ng/src/prefixes.dart';

bool isValid(String input) {
  final ParseResult result = parse(input);
  return result is ParseSuccess;
}
bool isPossible(String input) {
  final normalized = normalize(input);
  if (normalized is NormalizeSuccess) {
    return normalized.digits.length == mobileLength;
  }
  return false;
}