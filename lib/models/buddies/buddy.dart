import 'levels.dart';

class Buddy {
  String? uuid;
  String? displayName;
  bool? isHiddenIfNotOwned;
  String? themeUuid;
  String? displayIcon;
  String? assetPath;
  List<Levels>? levels;

  Buddy(
      {this.uuid,
      this.displayName,
      this.isHiddenIfNotOwned,
      this.themeUuid,
      this.displayIcon,
      this.assetPath,
      this.levels});

  Buddy.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    isHiddenIfNotOwned = json['isHiddenIfNotOwned'];
    themeUuid = json['themeUuid'];
    displayIcon = json['displayIcon'];
    assetPath = json['assetPath'];
    if (json['levels'] != null) {
      levels = <Levels>[];
      json['levels'].forEach((v) {
        levels!.add(Levels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['displayName'] = displayName;
    data['isHiddenIfNotOwned'] = isHiddenIfNotOwned;
    data['themeUuid'] = themeUuid;
    data['displayIcon'] = displayIcon;
    data['assetPath'] = assetPath;
    if (levels != null) {
      data['levels'] = levels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
