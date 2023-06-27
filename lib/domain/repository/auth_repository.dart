import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<dynamic>>> login({
    required String username,
    required String password,
  });
}