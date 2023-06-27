import 'package:flutter_modular/flutter_modular.dart';
import 'package:ingenious_test/presentation/module/contact/presentation/page.dart';

class ContactModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/',
      child: (_, args) => const ContactPage(),
      transition: TransitionType.rightToLeft,
    ),
  ];
}