// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payee _$PayeeFromJson(Map<String, dynamic> json) => Payee(
      id: json['id'] as int?,
      name: json['name'] as String,
      lastCategoryId: json['lastCategoryId'] as int? ?? 0,
    );

Map<String, dynamic> _$PayeeToJson(Payee instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastCategoryId': instance.lastCategoryId,
    };
