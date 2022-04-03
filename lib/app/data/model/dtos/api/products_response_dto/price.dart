import 'dart:convert';

class Price {
  int? current;
  String? currency;

  Price({this.current, this.currency});

  factory Price.fromMap(Map<String, dynamic> data) => Price(
        current: data['current'] as int?,
        currency: data['currency'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'current': current,
        'currency': currency,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Price].
  factory Price.fromJson(String data) {
    return Price.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Price] to a JSON string.
  String toJson() => json.encode(toMap());
}
