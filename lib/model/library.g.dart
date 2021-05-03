// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
      status: json['status'] as String,
      code: json['code'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      news: (json['news'] as List)
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'news': instance.news};

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      link: json['link'] as String,
      date: json['date'] as String,
      title: json['title'] as String,
      img: json['img'] as String,
      media: json['media'] as String);
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'link': instance.link,
      'date': instance.date,
      'title': instance.title,
      'img': instance.img,
      'media': instance.media
    };
