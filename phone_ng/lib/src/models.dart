enum Network {
  unknown,
  mafab,
  airtel,
  mtn,
  ntel,
  glo,
  nineMobile,
  smile,
  visafone,
}

enum EntryType { special, mobile, landline, tollFree, unknown }

enum ParseErrorCode {
  emptyInput,
  invalidCharacters,
  invalidLength,
  invalidCountryCode,
  invalidPrefix,
  tooShort,
  tooLong,
  notNigerian,
}

final class PrefixEntry {
  final Network network;
  final EntryType type;

  PrefixEntry({required this.network, required this.type});
}

final class ParseSuccess {
  final bool valid;
  final String e164;
  final String national;
  final String international;
  final String compact;
  final String rfc3966;
  final String prefix;
  final Network network;
  final EntryType type;

  ParseSuccess({
    required this.valid,
    required this.e164,
    required this.national,
    required this.international,
    required this.compact,
    required this.rfc3966,
    required this.prefix,
    required this.network,
    required this.type,
  });
}
