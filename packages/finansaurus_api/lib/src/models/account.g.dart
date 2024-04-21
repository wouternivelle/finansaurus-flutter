// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int?,
      amount: (json['amount'] as num).toDouble(),
      name: json['name'] as String,
      starred: json['starred'] as bool,
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'name': instance.name,
      'starred': instance.starred,
      'type': _$AccountTypeEnumMap[instance.type]!,
    };

const _$AccountTypeEnumMap = {
  AccountType.CHECKINGS: 'CHECKINGS',
  AccountType.SAVINGS: 'SAVINGS',
};
