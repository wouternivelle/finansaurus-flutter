import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'edit_account_event.dart';

part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc(
      {required FinansaurusRepository finansaurusRepository,
      required Account? initial})
      : _finansaurusRepository = finansaurusRepository,
        super(EditAccountState(
            initial: initial,
            name: initial?.name ?? '',
            type: initial?.type ?? AccountType.CHECKINGS,
            amount: initial?.amount ?? 0,
            starred: initial?.starred ?? false)) {
    on<EditAccountNameChanged>(_onNameChanged);
    on<EditAccountTypeChanged>(_onTypeChanged);
    on<EditAccountAmountChanged>(_onAmountChanged);
    on<EditAccountStarredChanged>(_onStarredChanged);
    on<EditAccountSubmitted>(_onSubmitted);
  }

  final FinansaurusRepository _finansaurusRepository;

  void _onNameChanged(
    EditAccountNameChanged event,
    Emitter<EditAccountState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onTypeChanged(
    EditAccountTypeChanged event,
    Emitter<EditAccountState> emit,
  ) {
    emit(state.copyWith(type: event.type));
  }

  void _onAmountChanged(
    EditAccountAmountChanged event,
    Emitter<EditAccountState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onStarredChanged(
    EditAccountStarredChanged event,
    Emitter<EditAccountState> emit,
  ) {
    emit(state.copyWith(starred: event.starred));
  }

  Future<void> _onSubmitted(
    EditAccountSubmitted event,
    Emitter<EditAccountState> emit,
  ) async {
    emit(state.copyWith(status: EditAccountStatus.loading));

    final account = (state.initial ?? Account.empty()).copyWith(
      name: state.name,
      type: state.type,
      amount: state.amount,
      starred: state.starred,
    );

    try {
      await _finansaurusRepository.saveAccount(account);
      emit(state.copyWith(status: EditAccountStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditAccountStatus.failure));
    }
  }
}
