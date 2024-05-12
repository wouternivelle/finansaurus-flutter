// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int?,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      accountId: json['accountId'] as int,
      categoryId: json['categoryId'] as int,
      payeeId: json['payeeId'] as int?,
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'accountId': instance.accountId,
      'categoryId': instance.categoryId,
      'payeeId': instance.payeeId,
      'date': instance.date.toIso8601String(),
      'note': instance.note,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.IN: 'IN',
  TransactionType.OUT: 'OUT',
};
