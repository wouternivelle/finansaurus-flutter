part of 'list_transactions_bloc.dart';

enum ListTransactionsStatus { initial, loading, success, failure }

final class ListTransactionsState extends Equatable {
  const ListTransactionsState({
    this.status = ListTransactionsStatus.initial,
    this.transactions = const [],
  });

  final ListTransactionsStatus status;
  final List<Transaction> transactions;

  ListTransactionsState copyWith({
    ListTransactionsStatus? status,
    List<Transaction>? transactions,
  }) {
    return ListTransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
      ];
}
