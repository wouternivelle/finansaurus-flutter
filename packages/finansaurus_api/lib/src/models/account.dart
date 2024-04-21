import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'account.g.dart';

@immutable
@JsonSerializable()
class Account extends Equatable {
  Account({
    this.id,
    required this.amount,
    required this.name,
    required this.starred,
    required this.type,
  });

  static Account empty() {
    return Account(
        amount: 0, name: '', starred: false, type: AccountType.CHECKINGS);
  }

  final int? id;
  final double amount;
  final String name;
  final bool starred;
  final AccountType type;

  Account copyWith(
      {int? id,
      double? amount,
      String? name,
      bool? starred,
      AccountType? type}) {
    return Account(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      name: name ?? this.name,
      starred: starred ?? this.starred,
      type: type ?? this.type,
    );
  }

  static Account fromJson(JsonMap json) => _$AccountFromJson(json);

  JsonMap toJson() => _$AccountToJson(this);

  @override
  List<Object?> get props => [id, amount, name, starred, type];
}

enum AccountType {
  CHECKINGS,
  SAVINGS;

  static AccountType of(String? name) {
    return AccountType.values.firstWhere((element) => element.name == name, orElse: () => AccountType.CHECKINGS);
  }
}
