import 'package:finansaurus_flutter/categories/edit/view/edit_category_page.dart';
import 'package:finansaurus_flutter/categories/list/bloc/list_categories_bloc.dart';
import 'package:finansaurus_flutter/categories/list/view/list_categories_tile.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCategoriesPage extends StatelessWidget {
  const ListCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCategoriesBloc(
        finansaurusRepository: context.read<FinansaurusRepository>(),
      )..add(const ListCategoriesSubscriptionRequested()),
      child: const ListCategoriesView(),
    );
  }
}

class ListCategoriesView extends StatelessWidget {
  const ListCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('listCategoriesView_addCategory_floatingActionButton'),
        onPressed: () async {
          await Navigator.of(context).push(
            EditCategoryPage.route(
                categories:
                    context.read<ListCategoriesBloc>().state.categories),
          );
          context
              .read<ListCategoriesBloc>()
              .add(const ListCategoriesSubscriptionRequested());
        },
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListCategoriesBloc, ListCategoriesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ListCategoriesStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Failed to list the categories'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<ListCategoriesBloc, ListCategoriesState>(
          builder: (context, state) {
            if (state.categories.isEmpty) {
              if (state.status == ListCategoriesStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != ListCategoriesStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No categories found',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return Scrollbar(
              child: ListView(
                children: [
                  for (final category in _orderCategories(state.categories))
                    ListCategoriesTile(
                      category: category,
                      onDismissed: (_) {
                        context
                            .read<ListCategoriesBloc>()
                            .add(CategoryDeleted(category));
                        context
                            .read<ListCategoriesBloc>()
                            .add(const ListCategoriesSubscriptionRequested());
                      },
                      onTap: () async {
                        await Navigator.of(context).push(
                          EditCategoryPage.route(
                              initial: category, categories: state.categories),
                        );
                        context
                            .read<ListCategoriesBloc>()
                            .add(const ListCategoriesSubscriptionRequested());
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Category> _orderCategories(List<Category> categories) {
    final List<Category> result = [];
    final parents = categories.where((category) => category.parent == null).toList();
    for (var parent in parents) {
      result.add(parent);
      result.addAll(categories.where((category) => category.parent == parent.id).toList());
    }
    return result;
  }
}


