import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'list_payees_event.dart';

part 'list_payees_state.dart';

class ListPayeesBloc extends Bloc<ListPayeesEvent, ListPayeesState> {
  ListPayeesBloc({
    required FinansaurusRepository finansaurusRepository,
  })  : _finansaurusRepository = finansaurusRepository,
        super(const ListPayeesState()) {
    on<ListPayeesSubscriptionRequested>(_onSubscriptionRequested);
    on<PayeeDeleted>(_onPayeeDeleted);
  }

  final FinansaurusRepository _finansaurusRepository;

  Future<void> _onSubscriptionRequested(
    ListPayeesSubscriptionRequested event,
    Emitter<ListPayeesState> emit,
  ) async {
    emit(state.copyWith(status: ListPayeesStatus.loading));

    await _finansaurusRepository
        .getPayees()
        .then((value) => emit(
            state.copyWith(status: ListPayeesStatus.success, payees: value)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListPayeesStatus.failure)));
  }

  Future<void> _onPayeeDeleted(
    PayeeDeleted event,
    Emitter<ListPayeesState> emit,
  ) async {
    emit(state.copyWith(status: ListPayeesStatus.loading));

    await _finansaurusRepository
        .deletePayee(event.payee.id ?? 0)
        .then((value) => emit(state.copyWith(status: ListPayeesStatus.success)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListPayeesStatus.failure)));
  }
}
