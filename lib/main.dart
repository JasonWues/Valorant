import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/theme/color.dart';
import 'package:valorant/views/agentView.dart';
import 'package:valorant/views/mainView.dart';
import 'package:valorant/views/weaponView.dart';

void main() async {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant',
      theme: ThemeData(
          fontFamily: "Noto_Serif_SC",
          useMaterial3: true,
          colorSchemeSeed: bluePrimaryColor),
      darkTheme: ThemeData(
          fontFamily: "Noto_Serif_SC",
          colorSchemeSeed: bluePrimaryColor,
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: "Home",
      routes: {
        "Home": (context) => const MainView(),
        "Agent": (context) => const AgentView(),
        "Weapon": (context) => const WeaponView()
      },
    );
  }
}
