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
    adsStats = json['adsStats'] != null
        ? new AdsStats.fromJson(json['adsStats'])
        : null;
    altShotgunStats = json['altShotgunStats'] != null
        ? new AltShotgunStats.fromJson(json['altShotgunStats'])
        : null;
    airBurstStats = json['airBurstStats'] != null
        ? new AirBurstStats.fromJson(json['airBurstStats'])
        : null;
    if (json['damageRanges'] != null) {
      damageRanges = <DamageRanges>[];
      json['damageRanges'].forEach((v) {
        damageRanges!.add(new DamageRanges.fromJson(v));
      });
    }
  }
}
