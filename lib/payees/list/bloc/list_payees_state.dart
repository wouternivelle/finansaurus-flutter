part of 'list_payees_bloc.dart';

enum ListPayeesStatus { initial, loading, success, failure }

final class ListPayeesState extends Equatable {
  const ListPayeesState({
    this.status = ListPayeesStatus.initial,
    this.payees = const [],
  });

  final ListPayeesStatus status;
  final List<Payee> payees;

  ListPayeesState copyWith({
    ListPayeesStatus? status,
    List<Payee>? payees,
  }) {
    return ListPayeesState(
      status: status ?? this.status,
      payees: payees ?? this.payees,
    );
  }

  @override
  List<Object?> get props => [
        status,
        payees,
      ];
}
