import 'package:phone_ng/src/models.dart';
import 'package:phone_ng/src/normalizer.dart';
import 'package:phone_ng/src/prefixes.dart';

ParseResult parse(String input) {
  final NormalizeResult normalized = normalize(input);

  if (normalized is NormalizeFailure) {
    return ParseFailure(reason: normalized.reason, valid: false, input: input);
  }

  final String digits = (normalized as NormalizeSuccess).digits;
  final int lengthOfDigits = digits.length;

  if (lengthOfDigits != mobileLength) {
    return ParseFailure(
      reason: lengthOfDigits < mobileLength
          ? ParseErrorCode.tooShort
          : ParseErrorCode.tooLong,
      valid: false,
      input: input,
    );
  }

  final String prefix3 = digits.substring(0, 3);

  final String prefixKey = "$trunkPrefix$prefix3";

  final PrefixEntry? prefixEntry = prefixMap[prefixKey];

  if (prefixEntry == null) {
    return ParseFailure(
      reason: ParseErrorCode.invalidPrefix,
      valid: false,
      input: input,
    );
  }

  return ParseSuccess(
    valid: true,
    e164: "$e164Prefix$digits",
    national: "$trunkPrefix$digits",
    international:
        "$intlPrefix$prefix3 ${digits.substring(3, 6)} ${digits.substring(6)}",
    compact: "$countryCode$digits",
    rfc3966: "tel:$e164Prefix$digits",
    prefix: prefixKey,
    network: prefixEntry.network,
    type: prefixEntry.type,
  );
}
