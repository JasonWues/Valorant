import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant/models/buddies/buddy.dart';
import 'package:valorant/models/sprays/spray.dart';
import 'package:valorant/models/weapons/weapon.dart';
import '../models/agents/agent.dart';
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
