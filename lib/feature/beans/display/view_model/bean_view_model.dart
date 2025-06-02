import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../domain/entity/bean.dart';
import '../../domain/usecase/get_beans_use_case.dart';

class BeanViewModel extends ChangeNotifier {
  BeanViewModel({required this.getBeansUseCase});

  List<Bean> _beans = [];
  UnmodifiableListView<Bean> get beans => UnmodifiableListView(_beans);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  int get totalCount => _totalCount;
  int _totalCount = 0;
  int get pageSize => _pageSize;
  int _pageSize = 0;
  int get currentPage => _currentPage;
  int _currentPage = 0;
  int get totalPages => _totalPages;
  int _totalPages = 0;

  final GetBeansUseCase getBeansUseCase;

  Future<void> fetchBeans() async {}

  Future<void> fetchMoreBeans() async {}
}
