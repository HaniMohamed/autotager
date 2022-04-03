class PaginatedRequestDto {
  PaginatedRequestDto({
    this.pageNumber,
    this.pageSize,
    this.searchText,
    this.locale = "en",
  });

  final String? searchText;
  final String locale;
  final int? pageNumber;
  final int? pageSize;

  Map<String, String> toMap() {
    return {
      'locale': locale.toString(),
      if (pageNumber != null) 'page': pageNumber.toString(),
      if (pageSize != null) 'limit': pageSize.toString(),
      if (searchText != null) "searchText": searchText!,
    };
  }
}
