// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../custom/customSearchClass.dart';
import '../enum/dataType.dart';
import '../models/searchModel.dart';
import '../view_models/provider.dart';

class AgentsView extends ConsumerWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(agentsProvider);
    return CustomScrollView(
      slivers: [
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
              onPressed: () async {
                final value = asyncValue.value!;
                final result = await showSearch<SearchModel?>(
                    context: context,
                    delegate: CustomSearchClass(value
                        .map((agent) => SearchModel(
                            displayIcon: agent.displayIcon,
                            displayName: agent.displayName,
                            dataType: DataType.agent))
                        .toList()));
                if (result != null) {
                  final agent = value.firstWhere(
                      (element) => element.displayIcon == result.displayIcon);

                  if (context.mounted) {
                    Navigator.of(context).pushNamed("Agent", arguments: agent);
                  }
                }
              },
            ),
          ],
        ),
        asyncValue.when(
            data: (data) {
              data.removeWhere((x) => x.fullPortrait == null);
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
                                    borderRadius:
                                        BorderRadius.circular(36 / 2)),
                                color: Colors.grey),
                          ))
                    ]),
                  );
                },
              );
            })
      ],
    );
  }
}
