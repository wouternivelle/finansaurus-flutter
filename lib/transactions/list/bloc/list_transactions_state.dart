part of 'list_transactions_bloc.dart';

enum ListTransactionsStatus { initial, loading, success, failure }

final class ListTransactionsState extends Equatable {
  const ListTransactionsState({
    this.status = ListTransactionsStatus.initial,
    this.transactions = const [],
    this.categories = const [],
    this.payees = const [],
    this.page = 0,
    this.size = 20,
    this.totalElements = 0,
    this.totalPages = 0,
    this.hasReachedMax = false,
  });

  final ListTransactionsStatus status;
  final List<Transaction> transactions;
  final List<Category> categories;
  final List<Payee> payees;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasReachedMax;

  ListTransactionsState copyWith({
    ListTransactionsStatus? status,
    List<Transaction>? transactions,
    List<Category>? categories,
    List<Payee>? payees,
    int? page,
    int? size,
    int? totalElements,
    int? totalPages,
    bool? hasReachedMax,
  }) {
    return ListTransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      categories: categories ?? this.categories,
      payees: payees ?? this.payees,
      page: page ?? this.page,
      size: size ?? this.size,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        payees,
        categories,
        page,
        size,
        totalElements,
        totalPages,
        hasReachedMax,
      ];
}
