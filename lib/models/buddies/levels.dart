class Levels {
  String? uuid;
  int? charmLevel;
  String? displayName;
  String? displayIcon;
  String? assetPath;

  Levels(
      {this.uuid,
      this.charmLevel,
      this.displayName,
      this.displayIcon,
      this.assetPath});

  Levels.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    charmLevel = json['charmLevel'];
    displayName = json['displayName'];
    displayIcon = json['displayIcon'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['charmLevel'] = charmLevel;
    data['displayName'] = displayName;
    data['displayIcon'] = displayIcon;
    data['assetPath'] = assetPath;
    return data;
  }
}
