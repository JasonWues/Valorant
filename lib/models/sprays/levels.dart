class Levels {
  String? uuid;
  int? sprayLevel;
  String? displayName;
  String? displayIcon;
  String? assetPath;

  Levels(
      {this.uuid,
      this.sprayLevel,
      this.displayName,
      this.displayIcon,
      this.assetPath});

  Levels.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    sprayLevel = json['sprayLevel'];
    displayName = json['displayName'];
    displayIcon = json['displayIcon'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['sprayLevel'] = sprayLevel;
    data['displayName'] = displayName;
    data['displayIcon'] = displayIcon;
    data['assetPath'] = assetPath;
    return data;
  }
}
