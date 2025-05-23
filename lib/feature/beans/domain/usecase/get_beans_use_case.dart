import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/model/bean_response_model.dart';
import '../repository/bean_repository.dart';

class GetBeansUseCase
    implements UseCase<BeanResponseModel, GetBeansUseCaseParams> {
  const GetBeansUseCase({required this.repository});

  final BeanRepository repository;

  @override
  Future<Either<Failure, BeanResponseModel>> call(
    GetBeansUseCaseParams params,
  ) async {
    return await repository.getBeans(
      pageSize: params.pageSize,
      currentPage: params.currentPage,
    );
  }
}

class GetBeansUseCaseParams extends Equatable {
  const GetBeansUseCaseParams({this.pageSize = 10, this.currentPage = 1});

  final int pageSize;
  final int currentPage;

  @override
  List<Object?> get props => [pageSize, currentPage];
}
