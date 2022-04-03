import 'dart:convert';

class Image {
  String? path;
  String? cachedPath;

  Image({this.path, this.cachedPath});

  factory Image.fromMap(Map<String, dynamic> data) => Image(
        path: data['path'] as String?,
        cachedPath: data['cachedPath'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'path': path,
        'cachedPath': cachedPath,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Image].
  factory Image.fromJson(String data) {
    return Image.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Image] to a JSON string.
  String toJson() => json.encode(toMap());
}
