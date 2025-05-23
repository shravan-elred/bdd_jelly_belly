import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/bean_response_model.dart';

abstract class BeanRepository {
  Future<Either<Failure, BeanResponseModel>> getBeans({
    int pageSize = 10,
    int currentPage = 1,
  });
}
