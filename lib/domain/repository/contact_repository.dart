import 'package:dartz/dartz.dart';
import 'package:ingenious_test/domain/entity/list_contact_entity.dart';

import '../../core/failure.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getListContact();
}