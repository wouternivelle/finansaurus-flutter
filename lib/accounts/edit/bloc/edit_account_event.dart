part of 'edit_account_bloc.dart';

sealed class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

final class EditAccountNameChanged extends EditAccountEvent {
  const EditAccountNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditAccountTypeChanged extends EditAccountEvent {
  const EditAccountTypeChanged(this.type);

  final AccountType type;

  @override
  List<Object> get props => [type];
}

final class EditAccountAmountChanged extends EditAccountEvent {
  const EditAccountAmountChanged(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

final class EditAccountStarredChanged extends EditAccountEvent {
  const EditAccountStarredChanged(this.starred);

  final bool starred;

  @override
  List<Object> get props => [starred];
}

final class EditAccountSubmitted extends EditAccountEvent {
  const EditAccountSubmitted();
}
