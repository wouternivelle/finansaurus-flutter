part of 'list_transactions_bloc.dart';

sealed class ListTransactionsEvent extends Equatable {
  const ListTransactionsEvent();

  @override
  List<Object> get props => [];
}

final class ListTransactionsSubscriptionRequested
    extends ListTransactionsEvent {
  const ListTransactionsSubscriptionRequested();
}

final class TransactionDeleted extends ListTransactionsEvent {
  const TransactionDeleted(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

final class TransactionsNeeded extends ListTransactionsEvent {
  @override
  List<Object> get props => [];
}