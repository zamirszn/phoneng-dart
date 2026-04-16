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

sealed class ParseResult{}

final class ParseSuccess extends ParseResult{
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

class ParseFailure extends ParseResult{
  final ParseErrorCode reason;
  final bool valid;
  final String input;

  ParseFailure({required this.reason, required this.valid, required this.input});

}


final class BatchResult{
  final List<ParseResult> results;
  final BatchSummary summary;

  BatchResult({required this.results, required this.summary});

}

final class BatchSummary{
  final int total;
  final int valid;
  final int invalid;
  final Map<Network, int> byNetwork;

  BatchSummary({required this.total, required this.valid, required this.invalid, required this.byNetwork});
 
}

sealed class NormalizeResult{

}

final class NormalizeSuccess extends NormalizeResult{
  final String digits;

  NormalizeSuccess({required this.digits});
}

final class NormalizeFailure extends NormalizeResult{
  final ParseErrorCode reason;

  NormalizeFailure({required this.reason});

}