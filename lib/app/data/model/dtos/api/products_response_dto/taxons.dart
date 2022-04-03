import 'dart:convert';

class Taxons {
  String? main;
  List<dynamic>? others;

  Taxons({this.main, this.others});

  factory Taxons.fromMap(Map<String, dynamic> data) => Taxons(
        main: data['main'] as String?,
        others: data['others'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'main': main,
        'others': others,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Taxons].
  factory Taxons.fromJson(String data) {
    return Taxons.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Taxons] to a JSON string.
  String toJson() => json.encode(toMap());
}
