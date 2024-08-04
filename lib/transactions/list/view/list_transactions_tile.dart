import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransactionsTile extends StatelessWidget {
  const ListTransactionsTile({
    required this.transaction,
    required this.categories,
    required this.payees,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Transaction transaction;
  final List<Category> categories;
  final List<Payee> payees;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
        key: UniqueKey(),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color: theme.colorScheme.error,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Icon(
            Icons.delete,
            color: Color(0xAAFFFFFF),
          ),
        ),
        child: Card(
          child: ListTile(
            onTap: onTap,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _findPayee(transaction.payeeId),
                  style: TextStyle(
                    color: transaction.type == TransactionType.OUT
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                Text(_findCategory(transaction.categoryId)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('€ ${transaction.amount}',
                    style: TextStyle(
                      color: transaction.type == TransactionType.OUT
                          ? Colors.red
                          : Colors.green,
                      fontSize: 15,
                    )),
                Text(DateFormat('dd-MM-yyyy').format(transaction.date),
                  style: const TextStyle(
                  fontSize: 15,
                )),
              ],
            ),
          ),
        ));
  }

  String _findPayee(int? payeeId) {
    if (payeeId == null) {
      return '';
    }
    return payees.firstWhere((payee) => payee.id == payeeId).name;
  }

  String _findCategory(int categoryId) {
    return categories.firstWhere((category) => category.id == categoryId).name;
  }
}
