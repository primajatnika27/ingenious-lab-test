import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ingenious_test/presentation/module/contact/config/contact_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constant_config.dart';
import '../core/app.dart';
import '../module/auth/config/auth_module.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => App()
      ..client = Dio(BaseOptions(
        baseUrl: Config.baseUrl,
        connectTimeout: 50000,
        receiveTimeout: 30000,
        contentType: "application/json; charset=utf-8",
      ))
      ..clientAuth = Dio(BaseOptions(
        baseUrl: Config.baseUrlAuth,
        connectTimeout: 50000,
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: 30000,
        contentType: "application/json; charset=utf-8",
      ))),
    AsyncBind((i) => SharedPreferences.getInstance()),
  ];

  // Provide all the routes for your module
  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/contact', module: ContactModule()),
  ];
}