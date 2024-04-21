part of 'edit_category_bloc.dart';

sealed class EditCategoryEvent extends Equatable {
  const EditCategoryEvent();

  @override
  List<Object?> get props => [];

}

final class EditCategoryNameChanged extends EditCategoryEvent {
  const EditCategoryNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditCategoryParentChanged extends EditCategoryEvent {
  const EditCategoryParentChanged(this.parent);

  final int? parent;

  @override
  List<Object?> get props => [parent];
}

final class EditCategorySubmitted extends EditCategoryEvent {
  const EditCategorySubmitted();
}
