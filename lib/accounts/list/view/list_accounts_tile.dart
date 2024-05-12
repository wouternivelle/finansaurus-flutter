import 'package:finansaurus_flutter/widget/amount_text.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';

class ListAccountsTile extends StatelessWidget {
  const ListAccountsTile({
    required this.account,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Account account;
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
            leading: account.type == AccountType.CHECKINGS
                ? Icon(Icons.attach_money)
                : Icon(Icons.savings),
            onTap: onTap,
            title: Text(
              account.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AmountText(amount: account.amount),
            trailing: onTap == null ? null : const Icon(Icons.chevron_right),
          ),
        ));
  }
}
