import 'package:phone_ng/phone_ng.dart';

void main() {
  print('--- Nigerian Phone Parser Example ---');

  // Test Case 1: Standard parsing
  final input = '09029709898';
  final result = parse(input);

  if (result is ParseSuccess) {
    print('Input: $input');
    print('Network: ${result.network.name.toUpperCase()}');
    print('International: ${result.international}');
    print('RFC3966: ${result.rfc3966}');
  }

  print('\n--- Batch Processing ---');

  // Test Case 2: Batch parsing
  final List<String> rawNumbers = [
    '08031112222', 
    '07013334444',
    '08055556666', 
    'invalid-no',  
    '09097778888', 
  ];

  final batch = parseMany(rawNumbers);

  print('Total processed: ${batch.summary.total}');
  print('Valid: ${batch.summary.valid}');
  print('Invalid: ${batch.summary.invalid}');

  print('\nBreakdown by Network:');
  batch.summary.byNetwork.forEach((network, count) {
    if (count > 0) {
      print('- ${network.name}: $count');
    }
  });
}