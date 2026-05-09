import 'package:flutter/material.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const SaujanaApp());
}

class SaujanaApp extends StatelessWidget {
  const SaujanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title:            'Saujana',
      debugShowCheckedModeBanner: false,
      theme:            AppTheme.light,
      darkTheme:        AppTheme.dark,
      themeMode:        ThemeMode.system,
      routerConfig:     appRouter,
    );
  }
}
