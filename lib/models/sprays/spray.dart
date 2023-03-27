import 'levels.dart';

class Spray {
  String? uuid;
  String? displayName;
  String? category;
  String? themeUuid;
  String? displayIcon;
  String? fullIcon;
  String? fullTransparentIcon;
  String? animationPng;
  String? animationGif;
  String? assetPath;
  List<Levels>? levels;

  Spray(
      {this.uuid,
      this.displayName,
      this.category,
      this.themeUuid,
      this.displayIcon,
      this.fullIcon,
      this.fullTransparentIcon,
      this.animationPng,
      this.animationGif,
      this.assetPath,
      this.levels});

  Spray.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    category = json['category'];
    themeUuid = json['themeUuid'];
    displayIcon = json['displayIcon'];
    fullIcon = json['fullIcon'];
    fullTransparentIcon = json['fullTransparentIcon'];
    animationPng = json['animationPng'];
    animationGif = json['animationGif'];
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
    data['category'] = category;
    data['themeUuid'] = themeUuid;
    data['displayIcon'] = displayIcon;
    data['fullIcon'] = fullIcon;
    data['fullTransparentIcon'] = fullTransparentIcon;
    data['animationPng'] = animationPng;
    data['animationGif'] = animationGif;
    data['assetPath'] = assetPath;
    if (levels != null) {
      data['levels'] = levels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
