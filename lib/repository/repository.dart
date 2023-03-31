import 'package:valorant/models/agents/agent.dart';
import 'package:valorant/models/buddies/buddy.dart';
import 'package:valorant/models/sprays/spray.dart';

import '../models/version.dart';
import '../models/weapons/weapon.dart';
import '../util/http.dart';

class Repository {
  final api = ValorantClientApi();
  Future<List<Agent>> getAgents() async {
    final result = await api.valorantGet("https://valorant-api.com/v1/agents");
    final data = result["data"] as List<dynamic>;
    List<Agent> agents = <Agent>[];
    for (var i = 0; i < data.length; i++) {
      agents.add(Agent.fromJson(data[i]));
    }
    return agents;
  }

  Future<List<Weapon>> getWeapons() async {
    final result = await api.valorantGet("https://valorant-api.com/v1/weapons");
    final data = result["data"] as List<dynamic>;
    List<Weapon> weapons = <Weapon>[];
    for (var i = 0; i < data.length; i++) {
      weapons.add(Weapon.fromJson(data[i]));
    }
    return weapons;
  }

  Future<List<Spray>> getSprays() async {
    final result = await api.valorantGet("https://valorant-api.com/v1/sprays");
    final data = result["data"] as List<dynamic>;
    List<Spray> sprays = <Spray>[];
    for (var i = 0; i < data.length; i++) {
      sprays.add(Spray.fromJson(data[i]));
    }
    return sprays;
  }

  Future<List<Buddy>> getBuddies() async {
    final result = await api.valorantGet("https://valorant-api.com/v1/buddies");
    final data = result["data"] as List<dynamic>;
    List<Buddy> buddies = <Buddy>[];
    for (var i = 0; i < data.length; i++) {
      buddies.add(Buddy.fromJson(data[i]));
    }
    return buddies;
  }

  Future<Version> gerVersion() async {
    final result = await api.valorantGet("https://valorant-api.com/v1/version");
    final data = Version.fromJson(result["data"]);
    return data;
  }

  Future<dynamic> download(String url, String fileName) async {
    final result = await api.valorantDownload(url, fileName);
    return result;
  }
}
