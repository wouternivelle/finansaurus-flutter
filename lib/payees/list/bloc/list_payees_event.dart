part of 'list_payees_bloc.dart';

sealed class ListPayeesEvent extends Equatable {
  const ListPayeesEvent();

  @override
  List<Object> get props => [];
}

final class ListPayeesSubscriptionRequested extends ListPayeesEvent {
  const ListPayeesSubscriptionRequested();
}

final class PayeeDeleted extends ListPayeesEvent {
  const PayeeDeleted(this.payee);

  final Payee payee;

  @override
  List<Object> get props => [payee];
}
