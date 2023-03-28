class Version {
  String? manifestId;
  String? branch;
  String? version;
  String? buildVersion;
  String? engineVersion;
  String? riotClientVersion;
  String? riotClientBuild;
  String? buildDate;

  Version(
      {this.manifestId,
      this.branch,
      this.version,
      this.buildVersion,
      this.engineVersion,
      this.riotClientVersion,
      this.riotClientBuild,
      this.buildDate});

  Version.fromJson(Map<String, dynamic> json) {
    manifestId = json['manifestId'];
    branch = json['branch'];
    version = json['version'];
    buildVersion = json['buildVersion'];
    engineVersion = json['engineVersion'];
    riotClientVersion = json['riotClientVersion'];
    riotClientBuild = json['riotClientBuild'];
    buildDate = json['buildDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manifestId'] = manifestId;
    data['branch'] = branch;
    data['version'] = version;
    data['buildVersion'] = buildVersion;
    data['engineVersion'] = engineVersion;
    data['riotClientVersion'] = riotClientVersion;
    data['riotClientBuild'] = riotClientBuild;
    data['buildDate'] = buildDate;
    return data;
  }
}
