import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';

class ListCategoriesTile extends StatelessWidget {
  const ListCategoriesTile({
    required this.category,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Category category;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
        key: Key('listCategories_dismissible_${category.id}'),
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
        child: Container(
            margin: category.parent != null ? EdgeInsets.only(left: 30) : null,
            child: Card(
              child: ListTile(
                onTap: onTap,
                title: Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: category.parent == null
                      ? TextStyle(fontWeight: FontWeight.bold)
                      : null,
                ),
                trailing:
                    onTap == null ? null : const Icon(Icons.chevron_right),
              ),
            )));
  }
}
