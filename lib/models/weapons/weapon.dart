import 'package:valorant/models/weapons/shopData.dart';
import 'package:valorant/models/weapons/skins.dart';
import 'package:valorant/models/weapons/weaponStats.dart';

class Weapon {
  String? uuid;
  String? displayName;
  String? category;
  String? defaultSkinUuid;
  String? displayIcon;
  String? killStreamIcon;
  String? assetPath;
  WeaponStats? weaponStats;
  ShopData? shopData;
  List<Skins>? skins;

  Weapon(
      {this.uuid,
      this.displayName,
      this.category,
      this.defaultSkinUuid,
      this.displayIcon,
      this.killStreamIcon,
      this.assetPath,
      this.weaponStats,
      this.shopData,
      this.skins});

  Weapon.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    category = json['category'];
    defaultSkinUuid = json['defaultSkinUuid'];
    displayIcon = json['displayIcon'];
    killStreamIcon = json['killStreamIcon'];
    assetPath = json['assetPath'];
    weaponStats = json['weaponStats'] != null
        ? WeaponStats.fromJson(json['weaponStats'])
        : null;
    shopData =
        json['shopData'] != null ? ShopData.fromJson(json['shopData']) : null;
    if (json['skins'] != null) {
      skins = <Skins>[];
      json['skins'].forEach((v) {
        skins!.add(Skins.fromJson(v));
      });
    }
  }
}
