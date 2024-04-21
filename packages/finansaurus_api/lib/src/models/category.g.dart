// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      name: json['name'] as String,
      type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
      hidden: json['hidden'] as bool,
      system: json['system'] as bool,
      parent: json['parent'] as int?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$CategoryTypeEnumMap[instance.type]!,
      'hidden': instance.hidden,
      'system': instance.system,
      'parent': instance.parent,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.GENERAL: 'GENERAL',
  CategoryType.INCOME_NEXT_MONTH: 'INCOME_NEXT_MONTH',
  CategoryType.INCOME_CURRENT_MONTH: 'INCOME_CURRENT_MONTH',
  CategoryType.INITIAL: 'INITIAL',
};
