import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ingenious_test/presentation/config/module_config.dart';
import 'package:ingenious_test/presentation/core/app.dart';
import 'package:ingenious_test/presentation/core/main_app.dart';
import 'package:logging/logging.dart';

Future<Null> main() async {
  // Activate logger in root
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
      '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}',
    );
  });

  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // wait initialized
  await App.init();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const MainApp(),
    ),
  );
}