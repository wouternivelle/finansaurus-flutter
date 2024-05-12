import 'package:finansaurus_flutter/widget/amount_text.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';

class ListTransactionsTile extends StatelessWidget {
  const ListTransactionsTile({
    required this.transaction,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Transaction transaction;
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
            title: AmountText(amount: transaction.amount),
            subtitle: Text(
              transaction.date.toIso8601String(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: onTap == null ? null : const Icon(Icons.chevron_right),
          ),
        ));
  }
}
