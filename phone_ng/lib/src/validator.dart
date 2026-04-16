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

  if (normalized is NormalizeFailure) {
    return false;
  }

  final String digits = (normalized as NormalizeSuccess).digits;

  if (digits.length != mobileLength) {
    return false;
  }

  return true;
}
