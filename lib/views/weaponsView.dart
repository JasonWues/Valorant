// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../view_models/provider.dart';

class WeaponsView extends ConsumerWidget {
  const WeaponsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(weaponsProvider);
    return Center(
        child: RefreshIndicator(
            onRefresh: () async {
              return await ref.refresh(weaponsProvider.future);
            },
            child: asyncValue.when(
                data: (data) {
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
                                  Navigator.of(context).pushNamed("Weapon",
                                      arguments: data[index]);
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Image.network(
                                              data[index].displayIcon!)),
                                      Text(data[index].displayName!)
                                    ],
                                  ),
                                ));
                          })
                      : const Text("Data is empty.");
                },
                error: (error, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child:
                            Card(elevation: 4, child: Text(error.toString())),
                      ),
                    ),
                loading: () {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                })));
  }
}
