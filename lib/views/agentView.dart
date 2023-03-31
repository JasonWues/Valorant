// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:valorant/models/agents/agent.dart';

class AgentView extends ConsumerWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Agent;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(args.displayName!),
          floating: true,
          snap: false,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: DecoratedBox(
              position: DecorationPosition.background,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(int.parse("0x${args.backgroundGradientColors![0]}")),
                Color(int.parse("0x${args.backgroundGradientColors![1]}")),
                Color(int.parse("0x${args.backgroundGradientColors![2]}")),
                Color(int.parse("0x${args.backgroundGradientColors![3]}")),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Image.network(
                args.background!,
                width: 350,
                height: 512,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Image.network(
          args.fullPortrait!,
          width: 352,
          height: 320,
          filterQuality: FilterQuality.high,
        )),
        SliverToBoxAdapter(
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  args.role!.displayIcon!,
                  width: 35,
                  height: 35,
                  filterQuality: FilterQuality.high,
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.role!.displayName!,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(args.role!.description!)
              ],
            ))
          ]),
        ),
        args.characterTags != null
            ? SliverToBoxAdapter(
                child: Center(
                    child: SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: args.characterTags!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child:
                            RawChip(label: Text(args.characterTags![index])));
                  },
                ),
              )))
            : const SliverToBoxAdapter(child: SizedBox.shrink()),
        SliverStack(
          insetOnOverlap: false,
          children: [
            SliverPositioned.fill(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                  child: Text("abilities".tr()),
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.only(top: 35),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Row(children: [
                    args.abilities![index].displayIcon != null
                        ? Image.network(
                            args.abilities![index].displayIcon!,
                            width: 50,
                            height: 50,
                            key: const ValueKey("AbilitiesIconImage"),
                          )
                        : const SizedBox.shrink(
                            key: ValueKey("emptyAbilitiesIconShrink"),
                          ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          args.abilities![index].displayName!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(args.abilities![index].description!)
                      ],
                    ))
                  ]);
                }, childCount: args.abilities!.length)))
          ],
        )
      ]),
    );
  }
}
