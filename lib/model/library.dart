import 'package:json_annotation/json_annotation.dart';

part 'library.g.dart';

@JsonSerializable(nullable: false)
class Response {
  final String status, code;
  final Data data;

  Response({this.status, this.code, this.data});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJSon() => _$ResponseToJson(this);
}

@JsonSerializable(nullable: false)
class Data {
  List<News> news;

  Data({this.news});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(nullable: false)
class News {
  String type, link, date, title, img, media;

  News({this.link, this.date, this.title, this.img, this.media});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['title'] = title;
    map['date'] = date;
    map['link'] = link;
    map['img'] = img;
    map['media'] = media;

    return map;
  }

  void setTypeID(type) {
    this.type = type;
  }
}
