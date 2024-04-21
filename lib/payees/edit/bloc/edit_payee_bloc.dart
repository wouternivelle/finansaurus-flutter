import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'edit_payee_event.dart';

part 'edit_payee_state.dart';

class EditPayeeBloc extends Bloc<EditPayeeEvent, EditPayeeState> {
  EditPayeeBloc(
      {required FinansaurusRepository finansaurusRepository,
      required Payee? initialPayee})
      : _finansaurusRepository = finansaurusRepository,
        super(EditPayeeState(
          initialPayee: initialPayee,
          name: initialPayee?.name ?? '',
        )) {
    on<EditPayeeNameChanged>(_onNameChanged);
    on<EditPayeeSubmitted>(_onSubmitted);
  }

  final FinansaurusRepository _finansaurusRepository;

  void _onNameChanged(
    EditPayeeNameChanged event,
    Emitter<EditPayeeState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onSubmitted(
    EditPayeeSubmitted event,
    Emitter<EditPayeeState> emit,
  ) async {
    emit(state.copyWith(status: EditPayeeStatus.loading));

    final payee = (state.initialPayee ?? Payee(name: '')).copyWith(
      name: state.name,
    );

    try {
      await _finansaurusRepository.savePayee(payee);
      emit(state.copyWith(status: EditPayeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditPayeeStatus.failure));
    }
  }
}
