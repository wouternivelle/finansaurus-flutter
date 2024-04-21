part of 'list_categories_bloc.dart';

sealed class ListCategoriesEvent extends Equatable {
  const ListCategoriesEvent();

  @override
  List<Object> get props => [];
}

final class ListCategoriesSubscriptionRequested extends ListCategoriesEvent {
  const ListCategoriesSubscriptionRequested();
}

final class CategoryDeleted extends ListCategoriesEvent {
  const CategoryDeleted(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
}
