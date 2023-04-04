// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../view_models/provider.dart';

class AgentsView extends ConsumerWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(agentsProvider);
    return RefreshIndicator(
        onRefresh: () async {
          return await ref.refresh(agentsProvider.future);
        },
        child: asyncValue.when(
            data: (data) {
              data.removeWhere((x) => x.fullPortrait == null);
              return data.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      padding: const EdgeInsets.all(10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("Agent", arguments: data[index]);
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data[index].displayIcon!),
                                  ),
                                ),
                                Text(data[index].displayName!),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Text("Data is empty.");
            },
            error: (error, _) => Text(error.toString()),
            loading: () {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: const ShapeDecoration(
                                shape: CircleBorder(), color: Colors.grey),
                          )),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            height: 18,
                            width: 85,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(36 / 2)),
                                color: Colors.grey),
                          ))
                    ]),
                  );
                },
              );
            }));
  }
}
