class Chromas {
  String? uuid;
  String? displayName;
  String? displayIcon;
  String? fullRender;
  String? swatch;
  String? streamedVideo;
  String? assetPath;

  Chromas(
      {this.uuid,
      this.displayName,
      this.displayIcon,
      this.fullRender,
      this.swatch,
      this.streamedVideo,
      this.assetPath});

  Chromas.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    displayIcon = json['displayIcon'];
    fullRender = json['fullRender'];
    swatch = json['swatch'];
    streamedVideo = json['streamedVideo'];
    assetPath = json['assetPath'];
  }
}
