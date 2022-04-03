import 'dart:convert';

import 'api/products_response_dto/product.dart';

class PaginatedResponseDto<TData> {
  int? page;
  int? limit;
  int? pages;
  int? total;
  Links? links;
  final List<TData>? items;

  PaginatedResponseDto._({
    this.page,
    this.limit,
    this.pages,
    this.total,
    this.links,
    this.items,
  });

  factory PaginatedResponseDto.fromMap(
      Map<String, dynamic> data, TData Function(dynamic) dataFromJson) {
    return PaginatedResponseDto._(
      page: data['page'] as int?,
      limit: data['limit'] as int?,
      pages: data['pages'] as int?,
      total: data['total'] as int?,
      links: data['_links'] == null
          ? null
          : Links.fromMap(data['_links'] as Map<String, dynamic>),
      items: data["items"] == null
          ? null
          : List<TData>.from(data["items"]?.map(dataFromJson)),
    );
  }

  Map<String, dynamic> toMap() => {
        'page': page,
        'limit': limit,
        'pages': pages,
        'total': total,
        '_links': links?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [PaginatedResponseDto] to a JSON string.
  String toJson() => json.encode(toMap());
}
