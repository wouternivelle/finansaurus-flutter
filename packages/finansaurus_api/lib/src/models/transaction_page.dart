import 'package:finansaurus_api/finansaurus_api.dart';

class TransactionPage {
  TransactionPage({
    required this.transactions,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  final List<Transaction> transactions;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
}
