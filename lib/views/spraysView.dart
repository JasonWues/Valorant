// ignore_for_file: file_names

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/provider.dart';

class SpraysView extends ConsumerWidget {
  const SpraysView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(spraysProvider);
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
                            if (data[index].fullIcon != null) {
                              final imageProvider =
                                  Image.network(data[index].fullIcon!).image;
                              showImageViewer(context, imageProvider);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Current Spray Not Found FullImage".tr()),
                              ));
                            }
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
                  : const Text('Data is empty.');
            },
            error: (error, _) => Text(error.toString()),
            loading: () => const CircularProgressIndicator()));
  }
}