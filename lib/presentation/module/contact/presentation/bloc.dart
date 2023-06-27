import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../core/failure.dart';
import '../../../../domain/entity/list_contact_entity.dart';
import '../../../../domain/repository/contact_repository.dart';

abstract class ContactState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {
  ContactLoadingState() : super();
}

class ContactDismissLoadingState extends ContactState {
  ContactDismissLoadingState() : super();
}

class ContactFailedState extends ContactState {
  final int code;
  final String message;

  ContactFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class ContactSuccessState extends ContactState {
  final List<ContactEntity>? entity;
  ContactSuccessState({
    required this.entity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [entity];
}

class ContactBloc extends Cubit<ContactState> {
  final ContactRepository repository;

  final TextEditingController searchController = TextEditingController();

  final Logger logger = Logger('ContactBloc');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<ContactEntity>? _listContact;
  List<ContactEntity>? _listSearchContact;

  ContactBloc({required this.repository}) : super(ContactInitialState());

  Future<void> getListContact() async {
    emit(ContactLoadingState());

    logger.fine('Get List Contact');

    Either<Failure, List<ContactEntity>> result =
    await repository.getListContact();

    ContactState stateResult = result.fold(
          (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return ContactFailedState(code: f.code, message: f.message);
      },
          (s) {
        logger.fine('Success data -> $s');
        List<ContactEntity> _data = s;
        _data.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        _listContact = _data;
        return ContactSuccessState(entity: _listContact);
      },
    );

    emit(stateResult);
  }

  Future<void> searchContact(String key) async {
    if (key.isNotEmpty) {
      print(key);
      _listSearchContact = _listContact
          ?.where((e) => e.name.toLowerCase().contains(key.toLowerCase()) || e.email.toLowerCase().contains(key.toLowerCase()))
          .toList();
      print('length ${_listSearchContact!.length}');
      emit(
        ContactSuccessState(entity: _listSearchContact),
      );
    } else {
      _listSearchContact = _listContact;
      emit(
        ContactSuccessState(entity: _listSearchContact),
      );
    }
  }
}

