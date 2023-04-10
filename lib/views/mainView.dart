// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../custom/customSearchClass.dart';
import '../view_models/provider.dart';
import 'agentsView.dart';
import 'buddies.dart';
import 'spraysView.dart';
import 'weaponsView.dart';

final selectIndexProvider = StateProvider<int>((ref) => 0);

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final version = ref.watch(versionProvider);
    final selectindex = ref.watch(selectIndexProvider);

    final List<bool> isSelect = [false, false, false]..[darkMode] = true;
    final views = <Widget>[
      const AgentsView(),
      const WeaponsView(),
      const SpraysView(),
      const BuddiesView()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorant"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchClass(ref));
              },
              icon: const Icon(Icons.search))
        ],
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
      bottomNavigationBar: SalomonBottomBar(
        items: <SalomonBottomBarItem>[
          SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: Text("Agents".tr()),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).disabledColor),
          SalomonBottomBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    "assets/svg/Weapons.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).disabledColor, BlendMode.srcIn),
                  )),
              activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    "assets/svg/Weapons.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  )),
              title: Text("Weapons".tr()),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).disabledColor),
          SalomonBottomBarItem(
              icon: Icon(Icons.school),
              title: Text("Sprays".tr()),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).disabledColor),
          SalomonBottomBarItem(
              icon: Icon(Icons.school),
              title: Text("Buddies".tr()),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).disabledColor)
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
    super.dispose();
  }
}
