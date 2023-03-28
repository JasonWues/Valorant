// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/views/buddies.dart';
import 'package:valorant/views/spraysView.dart';
import 'package:valorant/views/weaponsView.dart';

import '../view_models/provider.dart';
import 'agentsView.dart';

final selectIndexProvider = StateProvider<int>((ref) => 0);

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectindex = ref.watch(selectIndexProvider);
    final darkMode = ref.watch(darkModeProvider);
    final views = <Widget>[
      const AgentsView(),
      const WeaponsView(),
      const SpraysView(),
      const BuddiesView()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorant"),
      ),
      body: views[selectindex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SwitchListTile(
              title: Text("Dark Mode".tr()),
              secondary: const Icon(Icons.dark_mode),
              value: darkMode,
              onChanged: (value) {
                ref.read(darkModeProvider.notifier).toggle();
              },
            ),
            const AboutListTile(
              icon: Icon(Icons.info),
              applicationName: "Valorant",
              applicationVersion: "1.0",
              aboutBoxChildren: [],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Agents",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/Weapons.svg",
              colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(111, 111, 112, 1.0), BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              "assets/svg/Weapons.svg",
            ),
            label: "Weapons".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Sprays".tr(),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: "Buddies".tr())
        ],
        currentIndex: selectindex,
        onTap: (value) {
          ref
              .read(selectIndexProvider.notifier)
              .update((state) => state = value);
        },
      ),
    );
  }
}
