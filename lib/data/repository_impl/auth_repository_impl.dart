import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio client;

  final Logger logger = Logger('AuthRepositoryImpl');

  AuthRepositoryImpl({
    required this.client,
  });

  ///LOGIN
  @override
  Future<Either<Failure, List<dynamic>>> login(
      {required String username,
        required String password}) async {

    try {
      return Right([
        username
      ]);
    } catch (e) {
      logger.warning('Error -> $e');
      return Left(
        RequestFailure(
          code: 500,
          message: 'Something wrong, please try again.',
        ),
      );
    }
  }
}