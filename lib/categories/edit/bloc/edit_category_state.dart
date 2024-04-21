part of 'edit_category_bloc.dart';

enum EditCategoryStatus { initial, loading, success, failure }

extension EditCategoryStatusX on EditCategoryStatus {
  bool get isLoadingOrSuccess => [
        EditCategoryStatus.loading,
        EditCategoryStatus.success,
      ].contains(this);
}

final class EditCategoryState extends Equatable {
  const EditCategoryState({
    this.status = EditCategoryStatus.initial,
    this.initial,
    this.name = '',
    this.parent = null,
    this.parentCategories = const [],
  });

  final EditCategoryStatus status;
  final Category? initial;
  final String name;
  final int? parent;
  final List<Category> parentCategories;

  bool get isNew => initial == null;

  EditCategoryState copyWith({
    EditCategoryStatus? status,
    Category? initial,
    String? name,
    int? parent,
  }) {
    return EditCategoryState(
      status: status ?? this.status,
      initial: initial ?? this.initial,
      name: name ?? this.name,
      parent: parent,
      parentCategories: parentCategories,
    );
  }

  @override
  List<Object?> get props => [status, initial, name, parent];
}
