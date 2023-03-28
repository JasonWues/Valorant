// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:valorant/models/weapons/skins.dart';

class WeaponSkinView extends ConsumerWidget {
  const WeaponSkinView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Skins;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(args.displayName!),
            floating: true,
            snap: true,
          ),
          SliverStack(
            insetOnOverlap: false,
            children: [
              SliverPositioned.fill(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                  child: Text("chromas".tr()),
                ),
              )),
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(top: 35),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(children: [
                    Image.network(args.chromas![index].fullRender!),
                    Text(
                      args.chromas![index].displayName!.replaceAll("\n", " "),
                    )
                  ]);
                }, childCount: args.chromas!.length)),
              )
            ],
          ),
          SliverStack(
            insetOnOverlap: false,
            children: [
              SliverPositioned.fill(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                  child: Text("chromas".tr()),
                ),
              )),
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(top: 35),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(children: [
                    Image.network(args.levels![index].displayIcon!),
                    Text(
                      args.chromas![index].displayName!.replaceAll("\n", " "),
                    )
                  ]);
                }, childCount: args.levels!.length)),
              )
            ],
          )
        ],
      ),
    );
  }
}