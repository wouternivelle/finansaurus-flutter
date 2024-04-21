part of 'edit_payee_bloc.dart';

sealed class EditPayeeEvent extends Equatable {
  const EditPayeeEvent();

  @override
  List<Object> get props => [];
}

final class EditPayeeNameChanged extends EditPayeeEvent {
  const EditPayeeNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditPayeeSubmitted extends EditPayeeEvent {
  const EditPayeeSubmitted();
}
