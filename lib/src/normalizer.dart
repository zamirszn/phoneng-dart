import 'package:phone_ng/src/models.dart';
import 'package:phone_ng/src/prefixes.dart';

final RegExp parserLetterRegex = RegExp(r'[a-zA-Z]');
final RegExp nonDigitPlusRegex = RegExp(r'[^\d+]');

NormalizeResult normalize(dynamic input) {
  if (input == null || input is! String) {
    return NormalizeFailure(reason: ParseErrorCode.emptyInput);
  }

  String cleanedInput = input.trim();
  if (cleanedInput.isEmpty) {
    return NormalizeFailure(reason: ParseErrorCode.emptyInput);
  }

  if (cleanedInput.startsWith("tel:")) {
    cleanedInput = cleanedInput.substring(4);

    if (cleanedInput.isEmpty) {
      return NormalizeFailure(reason: ParseErrorCode.emptyInput);
    }
  }

  if (parserLetterRegex.hasMatch(cleanedInput)) {
    return NormalizeFailure(reason: ParseErrorCode.invalidCharacters);
  }

  final digitsOnly = cleanedInput.replaceAll(nonDigitPlusRegex, '');

  if (digitsOnly.isEmpty) {
    return NormalizeFailure(reason: ParseErrorCode.emptyInput);
  }

  String validInput = digitsOnly;

  if (validInput.startsWith("+")) {
    validInput = validInput.substring(1);
  }

  if (validInput.startsWith(countryCode)) {
    validInput = validInput.substring(countryCode.length);
  } else if (validInput.startsWith(trunkPrefix)) {
    validInput = validInput.substring(trunkPrefix.length);
  }

  if (validInput.isEmpty) {
    return NormalizeFailure(reason: ParseErrorCode.emptyInput);
  }

  return NormalizeSuccess(digits: validInput);
}
