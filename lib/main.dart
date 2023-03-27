import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/theme/color.dart';
import 'package:valorant/views/agentView.dart';
import 'package:valorant/views/mainView.dart';
import 'package:valorant/views/weaponSkinView.dart';
import 'package:valorant/views/weaponView.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valorant",
      theme: ThemeData(
          fontFamily: "SourceHanSansSC",
          useMaterial3: true,
          colorSchemeSeed: bluePrimaryColor),
      darkTheme: ThemeData(
          fontFamily: "SourceHanSansSC",
          colorSchemeSeed: bluePrimaryColor,
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: "Home",
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        "Home": (context) => const MainView(),
        "Agent": (context) => const AgentView(),
        "Weapon": (context) => const WeaponView(),
        "WeaponSkin": (context) => const WeaponSkinView()
      },
    );
  }
}
