// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:valorant/models/weapons/skins.dart';

class WeaponSkinView extends ConsumerWidget {
  const WeaponSkinView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Skins;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverStack(
            insetOnOverlap: false,
            children: [
              SliverPositioned.fill(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                  child: Text("chromas".tr()),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
