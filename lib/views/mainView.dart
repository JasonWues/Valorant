import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/views/weaponsView.dart';

import '../theme/color.dart';
import 'agentsView.dart';

final selectIndexProvider = StateProvider<int>((ref) => 0);

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectindex = ref.watch(selectIndexProvider);

    final views = <Widget>[AgentsView(), WeaponsView(), const Text("sss")];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorant"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: views[selectindex],
      bottomNavigationBar: BottomNavigationBar(
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
              colorFilter: ColorFilter.mode(bluePrimaryColor, BlendMode.srcIn),
            ),
            label: "Weapons",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
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
