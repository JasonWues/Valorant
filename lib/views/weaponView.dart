// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/models/weapons/weapon.dart';

class WeaponView extends ConsumerWidget {
  const WeaponView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Weapon;
    final weaponMap = args.toJson();
    final weaponStatsMap = args.weaponStats!.toJson();
    final shopDataMap = args.shopData!.toJson();
    final skins = args.skins;

    ExpansionTile getDamageRanges(
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

    Card getWeaponStatsCard() {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                child: Text("weaponStats".tr())),
            ListView.builder(
              shrinkWrap: true,
              itemCount: weaponStatsMap.length,
              itemBuilder: (context, index) {
                debugPrint(index.toString());
                if (weaponStatsMap.keys.elementAt(index) ==
                        "shotgunPelletCount" ||
                    weaponStatsMap.keys.elementAt(index) == "feature") {
                  return const SizedBox.shrink();
                }

                if (weaponStatsMap.keys.elementAt(index) == "damageRanges") {
                  final damageRangesList = weaponStatsMap.values
                      .elementAt(index) as List<Map<String, dynamic>>;
                  return getDamageRanges(damageRangesList, index);
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
                        weaponStatsMap.values.elementAt(index).toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ]),
                );
              },
            )
          ],
        ),
      );
    }

    Card getshopDataCard() {
      return Card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
          child: Text("shopData".tr()),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (shopDataMap.keys.elementAt(index) == "category" ||
                  shopDataMap.keys.elementAt(index) == "gridPosition") {
                return const SizedBox.shrink();
              }
              return Container(
                height: 30,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(children: [
                  Expanded(
                      child: Text(
                    shopDataMap.keys.elementAt(index).tr(),
                    style: const TextStyle(fontSize: 12),
                  )),
                  Expanded(
                    child: Text(
                      shopDataMap.values.elementAt(index).toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ]),
              );
            },
          ),
        )
      ]));
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(args.displayName!),
          floating: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (weaponMap.keys.elementAt(index) == "weaponStats") {
              return getWeaponStatsCard();
            }
            if (weaponMap.keys.elementAt(index) == "shopData") {
              return getshopDataCard();
            }
            return const SizedBox.shrink();
          }, childCount: weaponMap.length),
        )
      ],
    ));
  }
}
