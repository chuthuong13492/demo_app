import 'package:demo_app/core/widgets/paged_widget/src/pagination_model.dart';
import 'package:equatable/equatable.dart';

abstract interface class PagingAble<T extends Equatable> {
  Pagination<T> get pagination;

  Future<Pagination<T>> loadFirstPage();

  Future<Pagination<T>> loadMorePage(int page);

  Future<Pagination<T>> refreshPage();
}
