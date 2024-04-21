part of 'list_accounts_bloc.dart';

sealed class ListAccountsEvent extends Equatable {
  const ListAccountsEvent();

  @override
  List<Object> get props => [];
}

final class ListAccountsRequested extends ListAccountsEvent {
  const ListAccountsRequested();
}

final class AccountDeleted extends ListAccountsEvent {
  const AccountDeleted(this.account);

  final Account account;

  @override
  List<Object> get props => [account];
}
