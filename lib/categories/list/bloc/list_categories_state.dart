part of 'list_categories_bloc.dart';

enum ListCategoriesStatus { initial, loading, success, failure }

final class ListCategoriesState extends Equatable {
  const ListCategoriesState({
    this.status = ListCategoriesStatus.initial,
    this.categories = const [],
  });

  final ListCategoriesStatus status;
  final List<Category> categories;

  ListCategoriesState copyWith({
    ListCategoriesStatus? status,
    List<Category>? categories,
  }) {
    return ListCategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
      ];
}
