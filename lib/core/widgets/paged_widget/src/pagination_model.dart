/// Model for pagination data
class Pagination<T> {
  /// Create a pagination
  Pagination({
    required this.list,
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
    this.error,
  });

  /// Create an empty pagination
  factory Pagination.empty() => Pagination(
        list: [],
        page: 0,
        pageSize: 0,
        pageCount: 0,
        total: 0,
      );

  /// Pagination items
  final List<T> list;

  /// Current page
  final int page;

  /// Number of items per page
  final int pageSize;

  /// Total number of pages
  final int pageCount;

  /// Total number of items
  final int total;

  /// Whether the current page is the last page
  bool get isLast => page >= pageCount;

  /// Error during data loading if any
  final String? error;

  @override
  String toString() {
    return '$Pagination(list: [${list.map((e) => e.toString()).join(', ')}], page: $page, pageSize: $pageSize, pageCount: $pageCount, total: $total)';
  }

  /// Copy the pagination with new list
  Pagination<T> copyWith({
    List<T>? list,
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
    String? error,
  }) {
    return Pagination<T>(
      list: list ?? this.list,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      pageCount: pageCount ?? this.pageCount,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }

  /// Copy the pagination with new items
  Pagination<T> copyWithItem({
    required T Function(T value) update,
    required bool Function(T element) find,
  }) {
    final List<T> current = list;
    final int index = current.indexWhere(find);
    list[index] = update(list[index]);
    return copyWith(list: current);
  }
}
