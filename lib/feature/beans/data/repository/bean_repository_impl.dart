import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/bean_repository.dart';
import '../data_source/bean_local_data_source.dart';
import '../data_source/bean_remote_data_source.dart';
import '../model/bean_response_model.dart';

class BeanRepositoryImpl implements BeanRepository {
  const BeanRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final BeanRemoteDataSource remoteDataSource;
  final BeanLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, BeanResponseModel>> getBeans({
    int pageSize = 10,
    int currentPage = 1,
  }) {
    throw UnimplementedError();
  }
}
