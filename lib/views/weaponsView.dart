// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../custom/customSearchClass.dart';
import '../models/searchModel.dart';
import '../view_models/provider.dart';

class WeaponsView extends ConsumerWidget {
  const WeaponsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(weaponsProvider);
    return CustomScrollView(slivers: [
      SliverAppBar(
        forceElevated: true,
        elevation: 4,
        floating: true,
        snap: true,
        title: const Text(
          "Valorant",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchClass(asyncValue.value!
                      .map((weapon) => SearchModel(
                          displayIcon: weapon.displayIcon,
                          displayName: weapon.displayName))
                      .toList()));
            },
          ),
        ],
      ),
      asyncValue.when(
          data: (data) {
            return data.isNotEmpty
                ? SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("Weapon", arguments: data[index]);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image.network(
                                        data[index].displayIcon!)),
                                Text(data[index].displayName!)
                              ],
                            ),
                          ));
                    })
                : const SliverToBoxAdapter(child: Text("Data is empty."));
          },
          error: (error, _) =>
              SliverToBoxAdapter(child: Text(error.toString())),
          loading: () {
            return SliverGrid.builder(
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
                                  borderRadius: BorderRadius.circular(36 / 2)),
                              color: Colors.grey),
                        ))
                  ]),
                );
              },
            );
          })
    ]);
  }
}
