import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ingenious_test/core/failure.dart';
import 'package:ingenious_test/data/model/contact_model.dart';
import 'package:ingenious_test/domain/entity/list_contact_entity.dart';
import 'package:ingenious_test/domain/repository/contact_repository.dart';
import 'package:logging/logging.dart';

class ContactRepositoryImpl extends ContactRepository {
  final Dio client;

  final Logger logger = Logger('ContactRepositoryImpl');

  ContactRepositoryImpl({
    required this.client,
  });

  @override
  Future<Either<Failure, List<ContactEntity>>> getListContact() async {
    try {
      // final String response = await rootBundle.loadString('assets/json/contact.json');
      // final data = await json.decode(response);
      // return Right(ContactModel.parseEntries(data['data']));

      Response response = await client.get(
        '/contact/list/user',
      );

      if (response.statusCode == 200) {
        return Right(ContactModel.parseEntries(response.data[0]['data']));
      } else {
        return Left(
          RequestFailure(
            code: response.statusCode ?? 500,
            message: 'Something wrong, please try again.',
          ),
        );
      }
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