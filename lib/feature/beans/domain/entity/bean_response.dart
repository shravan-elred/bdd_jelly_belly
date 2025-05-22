import 'package:equatable/equatable.dart';
import 'bean.dart';

class BeanResponse extends Equatable {
  const BeanResponse({
    required this.totalCount,
    required this.pageSize,
    required this.currentPage,
    required this.totalPages,
    required this.items,
  });

  final int totalCount;
  final int pageSize;
  final int currentPage;
  final int totalPages;
  final List<Bean> items;

  @override
  List<Object?> get props => [
    totalCount,
    pageSize,
    currentPage,
    totalPages,
    items,
  ];
}
