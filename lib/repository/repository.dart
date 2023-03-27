import 'package:valorant/models/agents/agent.dart';
import 'package:valorant/models/sprays/spray.dart';

import '../models/weapons/weapon.dart';
import '../util/http.dart';

class Repository {
  final api = ValorantClientApi();
  Future<List<Agent>> getAgents() async {
    final result = await api.valorantGet("/v1/agents");
    final data = result["data"] as List<dynamic>;
    return data.map((agent) => Agent.fromJson(agent)).toList();
  }

  Future<List<Weapon>> getWeapons() async {
    final result = await api.valorantGet("/v1/weapons");
    final data = result["data"] as List<dynamic>;
    return data.map((weapon) => Weapon.fromJson(weapon)).toList();
  }

  Future<List<Spray>> getSprays() async {
    final result = await api.valorantGet("/v1/sprays");
    final data = result["data"] as List<dynamic>;
    return data.map((spray) => Spray.fromJson(spray)).toList();
  }
}
