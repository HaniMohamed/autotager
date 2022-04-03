import 'dart:convert';

import 'variant.dart';

class Variants {
  Variant? variant;

  Variants({this.variant});

  factory Variants.fromMap(Map<String, dynamic> data) {
    return Variants(
      variant: data.values.first == null
          ? null
          : Variant.fromMap(data.values.first as Map<String, dynamic>),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Variants].
  factory Variants.fromJson(String data) {
    return Variants.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
