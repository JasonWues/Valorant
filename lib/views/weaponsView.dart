// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/provider.dart';

class WeaponsView extends ConsumerWidget {
  const WeaponsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(weaponsProvider);
    return Center(
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
                              Navigator.of(context)
                                  .pushNamed("Weapon", arguments: data[index]);
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
                  : const Text('Data is empty.');
            },
            error: (error, _) => Text(error.toString()),
            loading: () => const CircularProgressIndicator()));
  }
}
