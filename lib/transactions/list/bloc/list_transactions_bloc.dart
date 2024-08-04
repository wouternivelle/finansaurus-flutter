import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'list_transactions_event.dart';
part 'list_transactions_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListTransactionsBloc
    extends Bloc<ListTransactionsEvent, ListTransactionsState> {
  ListTransactionsBloc({
    required FinansaurusRepository finansaurusRepository,
  })  : _finansaurusRepository = finansaurusRepository,
        super(const ListTransactionsState()) {
    on<ListTransactionsSubscriptionRequested>(_onSubscriptionRequested);
    on<TransactionDeleted>(_onTransactionDeleted);
    on<TransactionsNeeded>(_onTransactionsNeeded, transformer: throttleDroppable(throttleDuration));
  }

  final FinansaurusRepository _finansaurusRepository;

  Future<void> _onSubscriptionRequested(
    ListTransactionsSubscriptionRequested event,
    Emitter<ListTransactionsState> emit,
  ) async {
    emit(state.copyWith(status: ListTransactionsStatus.loading));

    await Future.wait([
      _finansaurusRepository.getCategories(),
      _finansaurusRepository.getPayees(),
      _finansaurusRepository.getTransactions(state.page, state.size)
    ]).then((values) {
      var categories = values[0] as List<Category>;
      var payees = values[1] as List<Payee>;
      var transactionsPage = values[2] as TransactionPage;
      return emit(state.copyWith(
        status: ListTransactionsStatus.success,
        transactions: transactionsPage.transactions,
        categories: categories,
        payees: payees,
        page: state.page + 1,
        size: transactionsPage.size,
        totalElements: transactionsPage.totalElements,
        totalPages: transactionsPage.totalPages,
      ));
    }).onError((error, stackTrace) =>
        emit(state.copyWith(status: ListTransactionsStatus.failure)));
  }

  Future<void> _onTransactionDeleted(
    TransactionDeleted event,
    Emitter<ListTransactionsState> emit,
  ) async {
    emit(state.copyWith(status: ListTransactionsStatus.loading));

    var transactions = state.transactions;
    await _finansaurusRepository
        .deleteTransaction(event.transaction.id ?? 0)
        .then((value) {
      transactions.remove(event.transaction);
      return emit(state.copyWith(
          transactions: transactions, status: ListTransactionsStatus.success));
    }).onError((error, stackTrace) =>
            emit(state.copyWith(status: ListTransactionsStatus.failure)));
  }

  Future<void> _onTransactionsNeeded(
    TransactionsNeeded event,
    Emitter<ListTransactionsState> emit,
  ) async {
    emit(state.copyWith(status: ListTransactionsStatus.loading));

    await _finansaurusRepository
        .getTransactions(state.page, state.size)
        .then((value) {
      state.transactions.addAll(value.transactions);
      bool hasReachedMax = value.transactions.isEmpty;
      return emit(state.copyWith(
        status: ListTransactionsStatus.success,
        transactions: state.transactions,
        page: value.page + 1,
        hasReachedMax: hasReachedMax,
      ));
    }).onError((error, stackTrace) =>
            emit(state.copyWith(status: ListTransactionsStatus.failure)));
  }
}
