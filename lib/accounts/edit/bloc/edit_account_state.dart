part of 'edit_account_bloc.dart';

enum EditAccountStatus { initial, loading, success, failure }

extension EditAccountStatusX on EditAccountStatus {
  bool get isLoadingOrSuccess => [
        EditAccountStatus.loading,
        EditAccountStatus.success,
      ].contains(this);
}

final class EditAccountState extends Equatable {
  const EditAccountState({
    this.status = EditAccountStatus.initial,
    this.initial,
    this.name = '',
    this.type = AccountType.CHECKINGS,
    this.amount = 0,
    this.starred = false,
  });

  final EditAccountStatus status;
  final Account? initial;
  final String name;
  final AccountType type;
  final double amount;
  final bool starred;

  bool get isNew => initial == null;

  EditAccountState copyWith({
    EditAccountStatus? status,
    Account? initial,
    String? name,
    AccountType? type,
    double? amount,
    bool? starred,
  }) {
    return EditAccountState(
      status: status ?? this.status,
      initial: initial ?? this.initial,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      starred: starred ?? this.starred,
    );
  }

  @override
  List<Object?> get props => [status, initial, name, type, amount, starred];
}
