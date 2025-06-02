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
  int _pageSize = 10;
  int get currentPage => _currentPage;
  int _currentPage = 1;
  int get totalPages => _totalPages;
  int _totalPages = 0;

  final GetBeansUseCase getBeansUseCase;

  Future<void> fetchBeans() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    final response = await getBeansUseCase.call(
      GetBeansUseCaseParams(pageSize: _pageSize, currentPage: _currentPage),
    );
    response.fold(
      (l) {
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _beans = r.items;
        _currentPage = r.currentPage;
        _totalCount = r.totalCount;
        _pageSize = r.pageSize;
        _totalPages = r.totalPages;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMoreBeans() async {
    if (_isLoading) return;
    if (_isLoadingMore) return;
    if (_totalPages <= currentPage) return;
    _isLoadingMore = true;
    notifyListeners();
    final response = await getBeansUseCase.call(
      GetBeansUseCaseParams(pageSize: _pageSize, currentPage: _currentPage + 1),
    );
    response.fold(
      (l) {
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _beans = [..._beans, ...r.items];
        _currentPage = r.currentPage;
        _totalCount = r.totalCount;
        _pageSize = r.pageSize;
        _totalPages = r.totalPages;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
