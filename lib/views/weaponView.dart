import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/models/weapons/weapon.dart';

class WeaponView extends ConsumerWidget {
  const WeaponView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Weapon;
    final weaponStatsMap = args.weaponStats!.toJson();
    return Scaffold(
      appBar: AppBar(title: Text(args.displayName!)),
      body: Column(children: [
        Image.network(
          args.displayIcon!,
          filterQuality: FilterQuality.high,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) =>
              const Text("Some errors occurred!"),
        ),
        Expanded(
            child: Card(
                child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      if (weaponStatsMap.keys.elementAt(index) == "adsStats") {
                        return ExpansionTile(
                            title: Text(weaponStatsMap.keys.elementAt(index)));
                      }
                      return Container(
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: [
                            Expanded(
                                child:
                                    Text(weaponStatsMap.keys.elementAt(index))
                                        .tr()),
                            Expanded(
                              child: Text(
                                  weaponStatsMap.values
                                      .elementAt(index)
                                      .toString(),
                                  textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                      );
                    }))),
      ]),
    );
  }
}
