// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/models/agents/agent.dart';
import 'package:valorant/theme/color.dart';

final selectIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class AgentView extends ConsumerWidget {
  const AgentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Agent;
    final selectIndex = ref.watch(selectIndexProvider);

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(args.displayName!),
          floating: true,
          snap: false,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: DecoratedBox(
              position: DecorationPosition.background,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(int.parse("0x${args.backgroundGradientColors![0]}")),
                Color(int.parse("0x${args.backgroundGradientColors![1]}")),
                Color(int.parse("0x${args.backgroundGradientColors![2]}")),
                Color(int.parse("0x${args.backgroundGradientColors![3]}")),
              ])),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: args.fullPortrait != null
              ? Image.network(
                  args.fullPortrait!,
                  width: 352,
                  height: 320,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Some errors occurred!'),
                )
              : const Text("Non Image"),
        ),
        SliverToBoxAdapter(
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  args.role!.displayIcon!,
                  width: 35,
                  height: 35,
                  filterQuality: FilterQuality.high,
                  color: bluePrimaryColor,
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
        SliverToBoxAdapter(
          child: Center(
              child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: args.abilities!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(selectIndexProvider.notifier)
                              .update((state) => state = index);
                        },
                        child: args.abilities![index].displayIcon != null
                            ? Image.network(
                                args.abilities![index].displayIcon!,
                                width: 50,
                                height: 50,
                                color: bluePrimaryColor,
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ))),
        ),
        SliverToBoxAdapter(
          child: Card(
            child: Column(children: [
              Text(args.abilities![selectIndex].displayName!),
              Text(args.abilities![selectIndex].description!)
            ]),
          ),
        )
      ]),
    );
  }
}
