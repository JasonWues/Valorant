import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/models/weapons/weapon.dart';

class WeaponView extends ConsumerWidget {
  const WeaponView({super.key});

  ExpansionTile getDamageRanges(Map<String, dynamic> weaponStatsMap,
      List<Map<String, dynamic>> damageRangesList, int index) {
    return ExpansionTile(
      title: Text(
        weaponStatsMap.keys.elementAt(index).tr(),
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
      children: damageRangesList.map((damageRanges) {
        return ExpansionTile(
          title: Text(
            "${damageRanges.values.elementAt(0)}${"meter".tr()}${"to".tr()}${damageRanges.values.elementAt(1)}${"meter".tr()}",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          children: damageRanges.entries.skip(2).map((entry) {
            return Container(
              height: 30,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    entry.key.tr(),
                    style: const TextStyle(fontSize: 12),
                  )),
                  Expanded(
                    child: Text(
                      entry.value.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Weapon;
    final weaponStatsMap = args.weaponStats!.toJson();
    return Scaffold(
        appBar: AppBar(title: Text(args.displayName!)),
        body: SingleChildScrollView(
            child: Column(children: [
          // Image.network(
          //   args.displayIcon!,
          //   filterQuality: FilterQuality.high,
          //   loadingBuilder: (context, child, loadingProgress) {
          //     if (loadingProgress == null) return child;
          //     return const CircularProgressIndicator();
          //   },
          //   errorBuilder: (context, error, stackTrace) =>
          //       const Text("Some errors occurred!"),
          // ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                    child: Text("weaponStats".tr())),
                SizedBox(
                    height: 360,
                    child: ListView.builder(
                      itemCount: weaponStatsMap.length,
                      itemBuilder: (context, index) {
                        if (weaponStatsMap.keys.elementAt(index) ==
                                "shotgunPelletCount" ||
                            weaponStatsMap.keys.elementAt(index) == "feature") {
                          return const SizedBox.shrink();
                        }

                        if (weaponStatsMap.keys.elementAt(index) ==
                            "damageRanges") {
                          final damageRangesList = weaponStatsMap.values
                              .elementAt(index) as List<Map<String, dynamic>>;
                          return getDamageRanges(
                              weaponStatsMap, damageRangesList, index);
                        }

                        return Container(
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(children: [
                            Expanded(
                                child: Text(
                              weaponStatsMap.keys.elementAt(index).tr(),
                              style: const TextStyle(fontSize: 12),
                            )),
                            Expanded(
                              child: Text(
                                weaponStatsMap.values
                                    .elementAt(index)
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ]),
                        );
                      },
                    ))
              ],
            ),
          ),
          Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                  child: Text("cost".tr()),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {},
                  ),
                )
              ]))
        ])));
  }
}
