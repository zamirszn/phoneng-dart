import 'package:phone_ng/src/models.dart';
import 'package:phone_ng/src/parser.dart';

BatchResult parseMany(List<String> inputs) {
  final List<ParseResult> results = inputs
      .map((input) => parse(input))
      .toList();

  final validResults = results.whereType<ParseSuccess>().toList();
  final int validCount = validResults.length;
  final int invalidCount = results.length - validCount;

  final Map<Network, int> byNetwork = {
    for (Network network in Network.values) network: 0,
  };

  for (ParseSuccess success in validResults) {
    byNetwork[success.network] = (byNetwork[success.network] ?? 0) + 1;
  }

  return BatchResult(
    results: results,
    summary: BatchSummary(
      total: results.length,
      valid: validCount,
      invalid: invalidCount,
      byNetwork: byNetwork,
    ),
  );
}
