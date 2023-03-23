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
        appBar: AppBar(
          title: Text(args.displayName!),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 5),
                onPressed: () {},
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(int.parse("0x${args.backgroundGradientColors![0]}")),
              Color(int.parse("0x${args.backgroundGradientColors![1]}")),
              Color(int.parse("0x${args.backgroundGradientColors![2]}")),
              Color(int.parse("0x${args.backgroundGradientColors![3]}")),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              args.fullPortrait != null
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
              const SizedBox(
                height: 5,
              ),
              Row(children: [
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
              args.characterTags != null
                  ? Expanded(
                      child: Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: args.characterTags!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: RawChip(
                                        label:
                                            Text(args.characterTags![index])));
                              })),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                  child: Center(
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
                        : const Text("被动"),
                  );
                },
              ))),
              Card(
                child: Column(
                  children: [
                    Text(args.abilities![selectIndex].displayName!),
                    Text(args.abilities![selectIndex].description!)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
