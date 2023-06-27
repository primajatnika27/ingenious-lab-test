import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/repository/auth_repository.dart';
import '../../../../core/app.dart';

abstract class AuthLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginInitialState extends AuthLoginState {}

class AuthLoginLoadingState extends AuthLoginState {}

class AuthLoginFailedState extends AuthLoginState {
  final int code;
  final String message;

  AuthLoginFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class AuthLoginSuccessState extends AuthLoginState {}

class AuthLoginGoState extends AuthLoginState {}

class AuthLoginBloc extends Cubit<AuthLoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthRepository repository;

  final Logger logger = Logger('AuthLoginBloc');

  AuthLoginBloc({required this.repository}) : super(AuthLoginInitialState());

  Future<void> signIn() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(AuthLoginLoadingState());

    logger.fine(
        'Submit -> username: ${usernameController.text} | password: ${passwordController.text}');

    Either<Failure, List<dynamic>> result = await repository.login(
      username: usernameController.text,
      password: passwordController.text,
    );

    AuthLoginState stateResult = result.fold(
          (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return AuthLoginFailedState(code: f.code, message: f.message);
      },
          (s) {
        logger.fine('Success data -> $s');
        App.main.username = s[0];
        return AuthLoginGoState();
      },
    );

    emit(stateResult);
  }

  void resetForm() {
    formKey.currentState!.reset();
    usernameController.clear();
    passwordController.clear();
  }
}