// ignore_for_file: file_names

import 'adsStats.dart';
import 'airBurstStats.dart';
import 'altShotgunStats.dart';
import 'damageRanges.dart';

class WeaponStats {
  double? fireRate;
  int? magazineSize;
  double? runSpeedMultiplier;
  double? equipTimeSeconds;
  double? reloadTimeSeconds;
  double? firstBulletAccuracy;
  int? shotgunPelletCount;
  String? wallPenetration;
  String? feature;
  String? fireMode;
  String? altFireType;
  AdsStats? adsStats;
  AltShotgunStats? altShotgunStats;
  AirBurstStats? airBurstStats;
  List<DamageRanges>? damageRanges;

  WeaponStats(
      {this.fireRate,
      this.magazineSize,
      this.runSpeedMultiplier,
      this.equipTimeSeconds,
      this.reloadTimeSeconds,
      this.firstBulletAccuracy,
      this.shotgunPelletCount,
      this.wallPenetration,
      this.feature,
      this.fireMode,
      this.altFireType,
      this.adsStats,
      this.altShotgunStats,
      this.airBurstStats,
      this.damageRanges});

  WeaponStats.fromJson(Map<String, dynamic> json) {
    fireRate = double.parse(json['fireRate'].toString());
    magazineSize = json['magazineSize'];
    runSpeedMultiplier = json['runSpeedMultiplier'];
    equipTimeSeconds = double.parse(json['equipTimeSeconds'].toString());
    reloadTimeSeconds = double.parse(json['reloadTimeSeconds'].toString());
    firstBulletAccuracy = double.parse(json['firstBulletAccuracy'].toString());
    shotgunPelletCount = json['shotgunPelletCount'];
    wallPenetration = json['wallPenetration'];
    feature = json['feature'];
    fireMode = json['fireMode'];
    altFireType = json['altFireType'];
    adsStats =
        json['adsStats'] != null ? AdsStats.fromJson(json['adsStats']) : null;
    altShotgunStats = json['altShotgunStats'] != null
        ? AltShotgunStats.fromJson(json['altShotgunStats'])
        : null;
    airBurstStats = json['airBurstStats'] != null
        ? AirBurstStats.fromJson(json['airBurstStats'])
        : null;
    if (json['damageRanges'] != null) {
      damageRanges = <DamageRanges>[];
      json['damageRanges'].forEach((v) {
        damageRanges!.add(DamageRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fireRate'] = fireRate;
    data['magazineSize'] = magazineSize;
    data['runSpeedMultiplier'] = runSpeedMultiplier;
    data['equipTimeSeconds'] = equipTimeSeconds;
    data['reloadTimeSeconds'] = reloadTimeSeconds;
    data['firstBulletAccuracy'] = firstBulletAccuracy;
    data['shotgunPelletCount'] = shotgunPelletCount;
    data['wallPenetration'] = wallPenetration;
    data['feature'] = feature;
    data['fireMode'] = fireMode;
    data['altFireType'] = altFireType;
    if (adsStats != null) {
      data['adsStats'] = adsStats!.toJson();
    }
    if (altShotgunStats != null) {
      data['altShotgunStats'] = altShotgunStats!.toJson();
    }
    if (airBurstStats != null) {
      data['airBurstStats'] = airBurstStats!.toJson();
    }
    if (damageRanges != null) {
      data['damageRanges'] = damageRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
