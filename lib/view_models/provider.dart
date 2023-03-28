import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/darkModeNotifier.dart';
import '../models/agents/agent.dart';
import '../models/buddies/buddy.dart';
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

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(),
);
