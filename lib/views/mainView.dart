// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:valorant/views/buddies.dart';
import 'package:valorant/views/spraysView.dart';
import 'package:valorant/views/weaponsView.dart';

import '../view_models/provider.dart';
import 'agentsView.dart';

final selectIndexProvider = StateProvider<int>((ref) => 0);

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final selectindex = ref.watch(selectIndexProvider);
    final darkMode = ref.watch(darkModeProvider);
    final version = ref.watch(versionProvider);

    final List<bool> isSelect = [false, false, false]..[darkMode] = true;
    final views = <Widget>[
      const AgentsView(),
      const WeaponsView(),
      const SpraysView(),
      const BuddiesView()
    ];

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Agents".tr(),
        ),
        PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              "assets/svg/Weapons.svg",
              colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(111, 111, 112, 1.0), BlendMode.srcIn),
            ),
            title: "Weapons".tr()),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.school),
          title: "Sprays".tr(),
        ),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.school), title: "Buddies".tr())
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorant"),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: views,
        items: _navBarsItems(),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
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
            Row(children: [
              const Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.settings_brightness,
                  ),
                  title: Text("Theme"),
                ),
              ),
              ToggleButtons(
                isSelected: isSelect,
                onPressed: (index) {
                  ref.read(darkModeProvider.notifier).toggle(index);
                },
                borderRadius: BorderRadius.circular(10),
                children: const [
                  Icon(Icons.brightness_medium),
                  Icon(Icons.light_mode),
                  Icon(Icons.dark_mode)
                ],
              ),
              const SizedBox(
                width: 20,
              )
            ]),
            Row(
              children: [
                const Expanded(
                  child: ListTile(
                    leading: Icon(
                      Icons.language,
                    ),
                    title: Text("Language"),
                  ),
                ),
                DropdownButton<Locale>(
                  value: context.locale,
                  items: context.supportedLocales
                      .map<DropdownMenuItem<Locale>>((locale) {
                    return DropdownMenuItem<Locale>(
                      value: locale,
                      child: Text(
                        locale.toString().tr(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.setLocale(value!);
                  },
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            AboutListTile(
              icon: const Icon(Icons.info),
              applicationName: "Valorant",
              applicationVersion: "1.0",
              aboutBoxChildren: [
                Text("Game BuildDate".tr()),
                version.when(
                    data: (data) {
                      return Text(data.buildDate!);
                    },
                    error: (error, _) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
