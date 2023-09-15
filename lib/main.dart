import 'package:assign_11/features/settings/models/settings.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:assign_11/router.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  await Hive.openBox<SettingModel>("settings");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    const ProviderScope(
      child: ThreadsApp(),
    ),
  );
}

class ThreadsApp extends ConsumerWidget {
  const ThreadsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
        Locale("ja"),
      ],
      themeMode:
          ref.watch(settingsProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: Colors.pink.shade200,
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        brightness: Brightness.light,
        textTheme: GoogleFonts.signikaTextTheme(
          ThemeData(brightness: Brightness.light).textTheme,
        ), //Typography.blackCupertino,
        dividerColor: Colors.grey.shade400,
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 2,
          indent: 0,
          endIndent: 0,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.pink.shade600,
          unselectedLabelColor: Colors.grey.shade500,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo.shade200,
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.signikaTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        dividerColor: Colors.white,
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 2,
          indent: 0,
          endIndent: 0,
        ),
      ),
    );
  }
}
