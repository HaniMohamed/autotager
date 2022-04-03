import 'dart:convert';

import 'image.dart';
import 'taxons.dart';
import 'variants.dart';

class Product {
  String? code;
  String? name;
  String? slug;
  String? channelCode;
  String? description;
  String? shortDescription;
  String? metaKeywords;
  String? metaDescription;
  int? averageRating;
  Taxons? taxons;
  Variants? variants;
  List<dynamic>? attributes;
  List<dynamic>? associations;
  List<Image>? images;
  Links? links;

  Product({
    this.code,
    this.name,
    this.slug,
    this.channelCode,
    this.description,
    this.shortDescription,
    this.metaKeywords,
    this.metaDescription,
    this.averageRating,
    this.taxons,
    this.variants,
    this.attributes,
    this.associations,
    this.images,
    this.links,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        code: data['code'] as String?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        channelCode: data['channelCode'] as String?,
        description: data['description'] as String?,
        shortDescription: data['shortDescription'] as String?,
        metaKeywords: data['metaKeywords'] as String?,
        metaDescription: data['metaDescription'] as String?,
        averageRating: data['averageRating'] as int?,
        taxons: data['taxons'] == null
            ? null
            : Taxons.fromMap(data['taxons'] as Map<String, dynamic>),
        variants: data['variants'] == null
            ? null
            : Variants.fromMap(data['variants'] as Map<String, dynamic>),
        attributes: data['attributes'] as List<dynamic>?,
        associations: data['associations'] as List<dynamic>?,
        images: (data['images'] as List<dynamic>?)
            ?.map((e) => Image.fromMap(e as Map<String, dynamic>))
            .toList() as List<Image>,
        links: data['_links'] == null
            ? null
            : Links.fromMap(data['_links'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'slug': slug,
        'channelCode': channelCode,
        'description': description,
        'shortDescription': shortDescription,
        'metaKeywords': metaKeywords,
        'metaDescription': metaDescription,
        'averageRating': averageRating,
        'taxons': taxons?.toMap(),
        'attributes': attributes,
        'associations': associations,
        'images': images?.map((e) => e.toMap()).toList(),
        '_links': links?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Links {
  dynamic? self;
  String? first;
  String? last;
  String? next;

  Links({this.self, this.first, this.last, this.next});

  factory Links.fromMap(Map<String, dynamic> data) => Links(
        self: data['self'] as dynamic?,
        first: data['first'] as String?,
        last: data['last'] as String?,
        next: data['next'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'self': self,
        'first': first,
        'last': last,
        'next': next,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Links].
  factory Links.fromJson(String data) {
    return Links.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Links] to a JSON string.
  String toJson() => json.encode(toMap());
}
