class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel(
      {this.src,
      this.photographer,
      this.photographer_id,
      this.photographer_url});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        //src: jsonData["src"],
        photographer_url: jsonData["photographer_url"],
        photographer_id: jsonData["photographer_id"],
        photographer: jsonData["photographer"],
        src: SrcModel.fromMap(jsonData["src"]));
  }
}

class SrcModel {
  String orignal;
  String small;
  String portrait;

  SrcModel({this.orignal, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        portrait: jsonData["portrait"],
        orignal: jsonData["orignal"],
        small: jsonData["samll"]);
  }
}
