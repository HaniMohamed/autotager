import 'dart:convert';

class Self {
  String? href;

  Self({this.href});

  factory Self.fromMap(Map<String, dynamic> data) => Self(
        href: data['href'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'href': href,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Self].
  factory Self.fromJson(String data) {
    return Self.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Self] to a JSON string.
  String toJson() => json.encode(toMap());
}
