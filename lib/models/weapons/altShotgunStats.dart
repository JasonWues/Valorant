class AltShotgunStats {
  int? shotgunPelletCount;
  double? burstRate;

  AltShotgunStats({this.shotgunPelletCount, this.burstRate});

  AltShotgunStats.fromJson(Map<String, dynamic> json) {
    shotgunPelletCount = json['shotgunPelletCount'];
    burstRate = json['burstRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shotgunPelletCount'] = shotgunPelletCount;
    data['burstRate'] = burstRate;
    return data;
  }
}
