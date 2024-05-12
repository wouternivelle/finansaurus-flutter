import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'transaction.g.dart';

@immutable
@JsonSerializable()
class Transaction extends Equatable {
  Transaction({
    this.id,
    required this.amount,
    required this.type,
    required this.accountId,
    required this.categoryId,
    required this.payeeId,
    required this.date,
    this.note,
  });

  final int? id;
  final double amount;
  final TransactionType type;
  final int accountId;
  final int categoryId;
  final int? payeeId;
  final DateTime date;
  final String? note;

  Transaction copyWith({
    int? id,
    double? amount,
    TransactionType? type,
    int? accountId,
    int? categoryId,
    int? payeeId,
    DateTime? date,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      payeeId: payeeId ?? this.payeeId,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  static Transaction fromJson(JsonMap json) => _$TransactionFromJson(json);

  JsonMap toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [
        this.id,
        amount,
        type,
        accountId,
        categoryId,
        payeeId,
        date,
        note,
      ];
}

enum TransactionType { IN, OUT }
