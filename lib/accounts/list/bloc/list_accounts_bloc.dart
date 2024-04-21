import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'list_accounts_event.dart';
part 'list_accounts_state.dart';

class ListAccountsBloc extends Bloc<ListAccountsEvent, ListAccountsState> {
  ListAccountsBloc({
    required FinansaurusRepository finansaurusRepository,
  })  : _finansaurusRepository = finansaurusRepository,
        super(const ListAccountsState()) {
    on<ListAccountsRequested>(_onRequested);
    on<AccountDeleted>(_onDeleted);
  }

  final FinansaurusRepository _finansaurusRepository;

  Future<void> _onRequested(
    ListAccountsRequested event,
    Emitter<ListAccountsState> emit,
  ) async {
    emit(state.copyWith(status: ListAccountsStatus.loading));

    await _finansaurusRepository
        .getAccounts()
        .then((value) => emit(state.copyWith(
            status: ListAccountsStatus.success, accounts: value)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListAccountsStatus.failure)));
  }

  Future<void> _onDeleted(
    AccountDeleted event,
    Emitter<ListAccountsState> emit,
  ) async {
    emit(state.copyWith(status: ListAccountsStatus.loading));

    await _finansaurusRepository
        .deleteAccount(event.account.id ?? 0)
        .then(
            (value) => emit(state.copyWith(status: ListAccountsStatus.success)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListAccountsStatus.failure)));
  }
}
