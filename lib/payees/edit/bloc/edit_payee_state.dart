part of 'edit_payee_bloc.dart';

enum EditPayeeStatus { initial, loading, success, failure }

extension EditPayeeStatusX on EditPayeeStatus {
  bool get isLoadingOrSuccess => [
    EditPayeeStatus.loading,
    EditPayeeStatus.success,
  ].contains(this);
}

final class EditPayeeState extends Equatable {
  const EditPayeeState({
    this.status = EditPayeeStatus.initial,
    this.initialPayee,
    this.name = '',
  });

  final EditPayeeStatus status;
  final Payee? initialPayee;
  final String name;

  bool get isNewPayee => initialPayee == null;

  EditPayeeState copyWith({
    EditPayeeStatus? status,
    Payee? initialPayee,
    String? name,
  }) {
    return EditPayeeState(
      status: status ?? this.status,
      initialPayee: initialPayee ?? this.initialPayee,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [status, initialPayee, name];
}
