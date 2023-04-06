import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:shimmer/shimmer.dart';

import '../view_models/provider.dart';

class BuddiesView extends ConsumerWidget {
  const BuddiesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(buddiesProvider);
    final repository = ref.read(repositoryProvider);
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
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 130,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FloatingActionButton(
                                                onPressed: () {},
                                                child: const Icon(Icons.share),
                                              ),
                                              Text("Share".tr())
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FloatingActionButton(
                                                onPressed: () async {
                                                  final filepath =
                                                      await FilePicker.platform
                                                          .getDirectoryPath();
                                                  if (filepath != null) {
                                                    final fileName = path.join(
                                                        filepath,
                                                        "${data[index].displayName!}.jpg");
                                                    await repository.download(
                                                        data[index]
                                                            .displayIcon!,
                                                        fileName);
                                                  }
                                                },
                                                child:
                                                    const Icon(Icons.download),
                                              ),
                                              Text("Download".tr())
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FloatingActionButton(
                                                onPressed: () {
                                                  if (data[index].displayIcon !=
                                                      null) {
                                                    final imageProvider = Image
                                                            .network(data[index]
                                                                .displayIcon!)
                                                        .image;
                                                    showImageViewer(
                                                        context, imageProvider);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Current Buddies Not Found FullImage"
                                                              .tr()),
                                                    ));
                                                  }
                                                },
                                                child: const Icon(Icons.image),
                                              ),
                                              Text("Preview".tr())
                                            ],
                                          )
                                        ]),
                                  );
                                });
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
            error: (error, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Card(elevation: 4, child: Text(error.toString())),
                  ),
                ),
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
