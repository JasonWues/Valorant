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
                  return Row(children: [
                    Expanded(
                        flex: 2,
                        child: Image.network(
                          args.chromas![index].fullRender!,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        )),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          args.chromas![index].displayName!
                              .replaceAll("\n", " "),
                        ),
                        args.chromas![index].streamedVideo != null
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("VideoPlay",
                                      arguments:
                                          args.chromas![index].streamedVideo);
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: Text("Play Video".tr()),
                              )
                            : const SizedBox.shrink()
                      ],
                    ))
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
                  child: Text("levels".tr()),
                ),
              )),
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(top: 35),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Row(children: [
                    args.levels![index].displayIcon != null
                        ? Expanded(
                            flex: 2,
                            child: Image.network(
                              args.levels![index].displayIcon!,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                            ))
                        : const SizedBox.shrink(),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          args.levels![index].displayName!
                              .replaceAll("\n", " "),
                        ),
                        args.levels![index].streamedVideo != null
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("VideoPlay",
                                      arguments:
                                          args.levels![index].streamedVideo);
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: Text("Play Video".tr()),
                              )
                            : const SizedBox.shrink()
                      ],
                    ))
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
