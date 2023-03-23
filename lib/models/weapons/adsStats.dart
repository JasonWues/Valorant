// ignore_for_file: file_names

class AdsStats {
  double? zoomMultiplier;
  double? fireRate;
  double? runSpeedMultiplier;
  int? burstCount;
  double? firstBulletAccuracy;

  AdsStats(
      {this.zoomMultiplier,
      this.fireRate,
      this.runSpeedMultiplier,
      this.burstCount,
      this.firstBulletAccuracy});

  AdsStats.fromJson(Map<String, dynamic> json) {
    zoomMultiplier = json['zoomMultiplier'];
    fireRate = double.parse(json['fireRate'].toString());
    runSpeedMultiplier = json['runSpeedMultiplier'];
    burstCount = json['burstCount'];
    firstBulletAccuracy = double.parse(json['firstBulletAccuracy'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zoomMultiplier'] = zoomMultiplier;
    data['fireRate'] = fireRate;
    data['runSpeedMultiplier'] = runSpeedMultiplier;
    data['burstCount'] = burstCount;
    data['firstBulletAccuracy'] = firstBulletAccuracy;
    return data;
  }
}
