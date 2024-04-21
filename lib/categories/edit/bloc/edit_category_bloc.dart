import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'edit_category_event.dart';
part 'edit_category_state.dart';

class EditCategoryBloc extends Bloc<EditCategoryEvent, EditCategoryState> {
  EditCategoryBloc({
    required FinansaurusRepository finansaurusRepository,
    required Category? initial,
    required List<Category> parentCategories,
  })  : _finansaurusRepository = finansaurusRepository,
        super(EditCategoryState(
          initial: initial,
          name: initial?.name ?? '',
          parent: initial?.parent,
          parentCategories: parentCategories,
        )) {
    on<EditCategoryNameChanged>(_onNameChanged);
    on<EditCategoryParentChanged>(_onParentChanged);
    on<EditCategorySubmitted>(_onSubmitted);
  }

  final FinansaurusRepository _finansaurusRepository;

  void _onNameChanged(
    EditCategoryNameChanged event,
    Emitter<EditCategoryState> emit,
  ) {
    emit(state.copyWith(name: event.name, parent: state.parent));
  }

  void _onParentChanged(
    EditCategoryParentChanged event,
    Emitter<EditCategoryState> emit,
  ) {
    emit(state.copyWith(parent: event.parent));
  }

  Future<void> _onSubmitted(
    EditCategorySubmitted event,
    Emitter<EditCategoryState> emit,
  ) async {
    emit(state.copyWith(status: EditCategoryStatus.loading, parent: state.parent));

    final category = (state.initial ?? Category.empty()).copyWith(
      name: state.name,
      parent: state.parent,
    );

    try {
      await _finansaurusRepository.saveCategory(category);
      emit(state.copyWith(status: EditCategoryStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditCategoryStatus.failure));
    }
  }
}
