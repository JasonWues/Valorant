// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/views/buddies.dart';
import 'package:valorant/views/searchView.dart';
import 'package:valorant/views/spraysView.dart';
import 'package:valorant/views/weaponsView.dart';

import '../themes/colors.dart';
import '../view_models/provider.dart';
import 'agentsView.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final version = ref.watch(versionProvider);

    final List<bool> isSelect = [false, false, false]..[darkMode] = true;
    final views = <Widget>[
      const AgentsView(),
      const WeaponsView(),
      const SearchView(),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Agents".tr(),
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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
