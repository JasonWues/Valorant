// ignore_for_file: file_names

class AirBurstStats {
  int? shotgunPelletCount;
  double? burstDistance;

  AirBurstStats({this.shotgunPelletCount, this.burstDistance});

  AirBurstStats.fromJson(Map<String, dynamic> json) {
    shotgunPelletCount = json['shotgunPelletCount'];
    burstDistance = json['burstDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shotgunPelletCount'] = shotgunPelletCount;
    data['burstDistance'] = burstDistance;
    return data;
  }
}
