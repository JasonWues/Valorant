// ignore_for_file: file_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:valorant/models/weapons/weapon.dart';

class WeaponView extends ConsumerWidget {
  const WeaponView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Weapon;
    final weaponStatsMap =
        args.weaponStats != null ? args.weaponStats!.toJson() : null;
    final shopDataMap = args.shopData != null ? args.shopData!.toJson() : null;
    final skins = args.skins;

    ExpansionTile getDamageRanges(
        List<Map<String, dynamic>> damageRangesList, int index) {
      return ExpansionTile(
        title: Text(
          weaponStatsMap!.keys.elementAt(index).tr(),
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

    ExpansionTile getAdsStats(int index) {
      final adsStats = weaponStatsMap!["adsStats"] as Map<String, dynamic>;
      return ExpansionTile(
        title: Text(
          weaponStatsMap.keys.elementAt(index).tr(),
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        children: adsStats.entries.map((entry) {
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
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(args.displayName!),
            floating: true,
            snap: true,
          ),
          weaponStatsMap != null
              ? SliverStack(
                  insetOnOverlap: false,
                  children: [
                    SliverPositioned.fill(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                          child: Text("weaponStats".tr()),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsetsDirectional.only(top: 35),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (weaponStatsMap.keys.elementAt(index) ==
                              "feature") {
                            return const SizedBox.shrink();
                          }

                          if (weaponStatsMap.keys.elementAt(index) ==
                              "damageRanges") {
                            final damageRangesList = weaponStatsMap.values
                                .elementAt(index) as List<Map<String, dynamic>>;
                            return getDamageRanges(damageRangesList, index);
                          }

                          if (weaponStatsMap.keys.elementAt(index) ==
                                  "wallPenetration" ||
                              weaponStatsMap.keys.elementAt(index) ==
                                  "fireMode" ||
                              weaponStatsMap.keys.elementAt(index) ==
                                  "altFireType") {
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
                                        .toString()
                                        .tr(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ]),
                            );
                          }

                          if (weaponStatsMap.keys.elementAt(index) ==
                              "adsStats") {
                            return getAdsStats(index);
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
                        }, childCount: weaponStatsMap.length),
                      ),
                    ),
                  ],
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          shopDataMap != null
              ? SliverStack(
                  insetOnOverlap: false,
                  children: <Widget>[
                    SliverPositioned.fill(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                          child: Text("shopData".tr()),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 35),
                      sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        if (shopDataMap.keys.elementAt(index) == "category" ||
                            shopDataMap.keys.elementAt(index) ==
                                "gridPosition") {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                shopDataMap.keys.elementAt(index).tr(),
                                style: const TextStyle(fontSize: 12),
                              )),
                              Expanded(
                                child: Text(
                                  shopDataMap.values
                                      .elementAt(index)
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: 5)),
                    )
                  ],
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (skins[index].displayName != null) {
                    return skins[index].displayIcon != null
                        ? Stack(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        "WeaponSkin",
                                        arguments: skins[index]);
                                  },
                                  child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: 1, sigmaY: 1),
                                      child: ShaderMask(
                                        shaderCallback: (rect) {
                                          return LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Colors.black,
                                                Colors.black.withOpacity(0)
                                              ],
                                              stops: const [
                                                0.15,
                                                0.75
                                              ]).createShader(rect);
                                        },
                                        blendMode: BlendMode.dstOut,
                                        child: Image.network(
                                          skins[index].displayIcon!,
                                        ),
                                      ))),
                              Positioned(
                                right: 30,
                                top: 25,
                                child: Text(
                                  skins[index].displayName!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : const SizedBox.shrink();
                  } else {
                    return const SizedBox.shrink();
                  }
                }, childCount: skins!.length),
              ))
        ],
      ),
    );
  }
}
