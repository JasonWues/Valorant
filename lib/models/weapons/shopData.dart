import 'gridPosition.dart';

class ShopData {
  int? cost;
  String? category;
  String? categoryText;
  GridPosition? gridPosition;
  bool? canBeTrashed;
  Null? image;
  String? newImage;
  Null? newImage2;
  String? assetPath;

  ShopData(
      {this.cost,
      this.category,
      this.categoryText,
      this.gridPosition,
      this.canBeTrashed,
      this.image,
      this.newImage,
      this.newImage2,
      this.assetPath});

  ShopData.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    category = json['category'];
    categoryText = json['categoryText'];
    gridPosition = json['gridPosition'] != null
        ? new GridPosition.fromJson(json['gridPosition'])
        : null;
    canBeTrashed = json['canBeTrashed'];
    image = json['image'];
    newImage = json['newImage'];
    newImage2 = json['newImage2'];
    assetPath = json['assetPath'];
  }
}
