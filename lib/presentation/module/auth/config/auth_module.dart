import 'package:flutter_modular/flutter_modular.dart';
import 'package:ingenious_test/presentation/module/auth/presentation/login/page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/login',
      child: (_, args) => const AuthLoginPage(),
      transition: TransitionType.rightToLeft,
    ),
  ];
}