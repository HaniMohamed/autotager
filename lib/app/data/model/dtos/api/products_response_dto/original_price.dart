import 'dart:convert';

class OriginalPrice {
  int? current;
  String? currency;

  OriginalPrice({this.current, this.currency});

  factory OriginalPrice.fromMap(Map<String, dynamic> data) => OriginalPrice(
        current: data['current'] as int?,
        currency: data['currency'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'current': current,
        'currency': currency,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OriginalPrice].
  factory OriginalPrice.fromJson(String data) {
    return OriginalPrice.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OriginalPrice] to a JSON string.
  String toJson() => json.encode(toMap());
}
