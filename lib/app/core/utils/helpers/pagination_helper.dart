import 'package:equatable/equatable.dart';

class PaginationHelper {
  static Pagination getNextPagination(int itemsCount, int pageSize,
      [bool fetchLatestIfHasRemaining = true,
      int minimumRemainingsToTake = 0,
      int minimumToRequest = 1]) {
    if (itemsCount == 0) {
      return Pagination(1, pageSize);
    }
    var latestPage = getLatestPage(itemsCount, pageSize);
    if (latestPage.hasRemaining) {
      if (fetchLatestIfHasRemaining ||
          latestPage.count < minimumRemainingsToTake) {
        return Pagination(latestPage.pageNumber, pageSize);
      } else {
        return _calcutaionOptimizedPagination(itemsCount, pageSize,
            latestPage.remainingsCount, latestPage, minimumToRequest);
      }
    }
    return Pagination(latestPage.pageNumber + 1, pageSize);
  }

  static Pagination _calcutaionOptimizedPagination(
      int itemsCount, int pageSize, int remainings, Page lastPage,
      [int minimumToRequest = 1, bool willHaveDuplicates = false]) {
    var gcd = lastPage.expectedTotalCount.gcd(remainings);
    //todo:add minmum to request if (gcd >= remainings && gcd >= minimumToRequest) {
    if (gcd >= remainings) {
      return Pagination(
          lastPage.pageNumber * pageSize ~/ gcd, gcd, willHaveDuplicates);
    } else {
      var newPageSize = remainings + 1;
      var newLastPage = getLatestPage(itemsCount, newPageSize);
      return _calcutaionOptimizedPagination(itemsCount, newPageSize,
          newPageSize, newLastPage, minimumToRequest, true);
    }
  }

  static Page getLatestPage(int itemsCount, int pageSize) {
    if (itemsCount <= pageSize) {
      return Page(1, itemsCount, pageSize - itemsCount);
    }
    var pageNumber = (itemsCount / pageSize).ceil();
    var remaining = itemsCount % pageSize;
    var latestPageItems = remaining == 0 ? pageSize : remaining;
    return Page(pageNumber, latestPageItems, pageSize - latestPageItems);
  }
}

class Pagination extends Equatable {
  final int pageNumber;
  final int pageSize;
  final bool shouldHasDuplicates;

  Pagination(this.pageNumber, this.pageSize,
      [this.shouldHasDuplicates = false]);

  @override
  List<Object> get props => [pageNumber, pageSize, shouldHasDuplicates];

  @override
  bool get stringify => true;
}

class Page extends Equatable {
  final int pageNumber;
  final int count;
  final int remainingsCount;
  bool get hasRemaining => remainingsCount > 0;
  int get pageSize => remainingsCount + count;
  int get currentTotalCount => ((pageNumber - 1) * pageSize) + count;
  int get expectedTotalCount => currentTotalCount + remainingsCount;
  Page(this.pageNumber, this.count, this.remainingsCount);

  @override
  List<Object> get props => [pageNumber, count, remainingsCount];

  @override
  bool get stringify => true;
}
