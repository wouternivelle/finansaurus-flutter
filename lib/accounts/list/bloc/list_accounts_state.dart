part of 'list_accounts_bloc.dart';

enum ListAccountsStatus { initial, loading, success, failure }

final class ListAccountsState extends Equatable {
  const ListAccountsState({
    this.status = ListAccountsStatus.initial,
    this.accounts = const [],
  });

  final ListAccountsStatus status;
  final List<Account> accounts;

  ListAccountsState copyWith({
    ListAccountsStatus? status,
    List<Account>? accounts,
  }) {
    return ListAccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        accounts,
      ];
}
