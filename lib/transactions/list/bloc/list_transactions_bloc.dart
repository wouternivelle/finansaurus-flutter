import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'list_transactions_event.dart';
part 'list_transactions_state.dart';

class ListTransactionsBloc
    extends Bloc<ListTransactionsEvent, ListTransactionsState> {
  ListTransactionsBloc({
    required FinansaurusRepository finansaurusRepository,
  })  : _finansaurusRepository = finansaurusRepository,
        super(const ListTransactionsState()) {
    on<ListTransactionsSubscriptionRequested>(_onSubscriptionRequested);
    on<TransactionDeleted>(_onTransactionDeleted);
  }

  final FinansaurusRepository _finansaurusRepository;

  Future<void> _onSubscriptionRequested(
    ListTransactionsSubscriptionRequested event,
    Emitter<ListTransactionsState> emit,
  ) async {
    emit(state.copyWith(status: ListTransactionsStatus.loading));

    await _finansaurusRepository
        .getTransactions(0, 10)
        .then((value) => emit(state.copyWith(
            status: ListTransactionsStatus.success, transactions: value)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListTransactionsStatus.failure)));
  }

  Future<void> _onTransactionDeleted(
    TransactionDeleted event,
    Emitter<ListTransactionsState> emit,
  ) async {
    emit(state.copyWith(status: ListTransactionsStatus.loading));

    await _finansaurusRepository
        .deleteTransaction(event.transaction.id ?? 0)
        .then((value) =>
            emit(state.copyWith(status: ListTransactionsStatus.success)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListTransactionsStatus.failure)));
  }
}
