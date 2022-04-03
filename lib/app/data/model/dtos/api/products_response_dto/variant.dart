import 'dart:convert';

import 'name_axis.dart';
import 'original_price.dart';
import 'price.dart';

class Variant {
  String? code;
  String? name;
  List<dynamic>? axis;
  NameAxis? nameAxis;
  bool? available;
  Price? price;
  OriginalPrice? originalPrice;
  List<dynamic>? images;

  Variant({
    this.code,
    this.name,
    this.axis,
    this.nameAxis,
    this.available,
    this.price,
    this.originalPrice,
    this.images,
  });

  factory Variant.fromMap(Map<String, dynamic> data) => Variant(
        code: data['code'] as String?,
        name: data['name'] as String?,
        axis: data['axis'] as List<dynamic>?,
        available: data['available'] as bool?,
        price: data['price'] == null
            ? null
            : Price.fromMap(data['price'] as Map<String, dynamic>),
        originalPrice: data['originalPrice'] == null
            ? null
            : OriginalPrice.fromMap(
                data['originalPrice'] as Map<String, dynamic>),
        images: data['images'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'axis': axis,
        'available': available,
        'price': price?.toMap(),
        'originalPrice': originalPrice?.toMap(),
        'images': images,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [5429].
  factory Variant.fromJson(String data) {
    return Variant.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [5429] to a JSON string.
  String toJson() => json.encode(toMap());
}
