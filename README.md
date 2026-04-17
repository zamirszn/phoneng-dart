# phone_ng

A comprehensive Dart utility for parsing, validating, and formatting Nigerian phone numbers. This package provides robust handling for mobile and landline numbers, carrier identification, and batch processing.

## Features

- **Robust Parsing**: Convert raw input strings into structured `ParseResult` objects.
- **Validation**: Check if a number is a valid Nigerian format or simply "possible" based on length.
- **Carrier Identification**: Identify networks including MTN, Airtel, Glo, 9mobile, Smile, and Mafab.
- **Standardized Formatting**: Support for E.164, National, International, and RFC3966 formats.
- **Batch Processing**: Parse multiple inputs at once with a detailed summary of results and network distribution.
- **Normalization**: Clean and sanitize inputs, removing non-digit characters and handling the `tel:` prefix.

## Installation

Add `phone_ng` to your `pubspec.yaml`:

```yaml
dependencies:
  phone_ng: ^1.0.0
```

## Usage

### Simple Validation
Quickly check if a string is a valid Nigerian phone number.

```dart
import 'package:phone_ng/phone_ng.dart';

void main() {
  bool valid = isValid('09029709898'); // true
  bool possible = isPossible('+234 902 970 9898'); // true
}
```

### Detailed Parsing
The `parse()` function returns a `ParseResult`, which can be a `ParseSuccess` containing detailed metadata or a `ParseFailure` explaining why validation failed.

```dart
import 'package:phone_ng/phone_ng.dart';

void main() {
  final result = parse('09029709898');

  if (result is ParseSuccess) {
    print(result.network);       // Network.mtn
    print(result.international); // +234 803 123 4567
    print(result.e164);          // +2348031234567
    print(result.type);          // EntryType.mobile
  } else if (result is ParseFailure) {
    print(result.reason);        // e.g., ParseErrorCode.invalidPrefix
  }
}
```

### Batch Processing
Process a list of strings and get a summary of the results.

```dart
import 'package:phone_ng/phone_ng.dart';

void main() {
  List<String> inputs = ['08031112222', '08023334444', 'invalid-number'];
  final batch = parseMany(inputs);

  print('Total: ${batch.summary.total}');     // 3
  print('Valid: ${batch.summary.valid}');     // 2
  print('MTN Count: ${batch.summary.byNetwork[Network.mtn]}'); // 1
}
```

## Supported Networks
The package recognizes prefixes for the following Nigerian providers:
- MTN
- Airtel
- Glo
- 9mobile
- Mafab
- Smile
- ntel
- Visafone

## API Reference

### Formats
| Format | Method / Property | Example Output |
| :--- | :--- | :--- |
| **E.164** | `result.e164` | `+2348031234567` |
| **National** | `result.national` | `08031234567` |
| **International** | `result.international` | `+234 803 123 4567` |
| **RFC3966** | `result.rfc3966` | `tel:+2348031234567` |
| **Compact** | `result.compact` | `2348031234567` |

### Error Codes
When parsing fails, one of the following reasons is provided:
- `invalidCharacters`: Input contains non-numeric symbols.
- `invalidPrefix`: The prefix does not match any known Nigerian network.
- `tooShort` / `tooLong`: The number of digits does not meet the standard length.
- `emptyInput`: The input string was null or empty.