import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/darkModeNotifier.dart';
import '../models/agents/agent.dart';
import '../models/buddies/buddy.dart';
import '../models/searchModel.dart';
import '../models/sprays/spray.dart';
import '../models/version.dart';
import '../models/weapons/weapon.dart';
import '../repository/repository.dart';

final repositoryProvider = Provider((ref) => Repository());

final agentsProvider = FutureProvider<List<Agent>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.getAgents();
});

final weaponsProvider = FutureProvider<List<Weapon>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.getWeapons();
});

final spraysProvider = FutureProvider<List<Spray>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.getSprays();
});

final buddiesProvider = FutureProvider<List<Buddy>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.getBuddies();
});

final versionProvider = FutureProvider<Version>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.gerVersion();
});

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, int>(
  (ref) => DarkModeNotifier(),
);

final searchpProvider = FutureProvider.autoDispose
    .family<List<SearchModel>, String>((ref, searchText) async {
  if (searchText.isEmpty) {
    return List.empty();
  }
  final repository = ref.read(repositoryProvider);
  final agentList = await repository.getAgents();
  final weaponList = await repository.getWeapons();
  final sprayList = await repository.getSprays();
  final buddieList = await repository.getBuddies();

  final searchList = agentList
      .where((agent) => agent.displayName!.contains(searchText))
      .map((agent) => SearchModel(
          displayIcon: agent.displayIcon, displayName: agent.displayName))
      .toList()
    ..addAll(weaponList
        .where((weapon) => weapon.displayName!.contains(searchText))
        .map((weapon) => SearchModel(
            displayIcon: weapon.displayIcon, displayName: weapon.displayName))
        .toList())
    ..addAll(sprayList
        .where((spray) => spray.displayName!.contains(searchText))
        .map((spray) => SearchModel(
            displayIcon: spray.displayIcon, displayName: spray.displayName))
        .toList())
    ..addAll(buddieList
        .where((buddie) => buddie.displayName!.contains(searchText))
        .map((buddie) => SearchModel(
            displayIcon: buddie.displayIcon, displayName: buddie.displayName))
        .toList());
  return searchList;
});
