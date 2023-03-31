import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view_models/provider.dart';
import 'views/agentView.dart';
import 'views/mainView.dart';
import 'views/weaponSkinView.dart';
import 'views/weaponView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [Locale("en", "US"), Locale("zh", "CN")],
    path: "assets/translations",
    fallbackLocale: const Locale("en", "US"),
    child: const ProviderScope(
      child: MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return MaterialApp(
      title: "Valorant",
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.values[darkMode],
      debugShowCheckedModeBanner: false,
      initialRoute: "Home",
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        "Home": (context) => const MainView(),
        "Agent": (context) => const AgentView(),
        "Weapon": (context) => const WeaponView(),
        "WeaponSkin": (context) => const WeaponSkinView(),
      },
    );
  }
}
