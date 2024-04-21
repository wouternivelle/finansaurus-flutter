import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';

part 'list_categories_event.dart';
part 'list_categories_state.dart';

class ListCategoriesBloc
    extends Bloc<ListCategoriesEvent, ListCategoriesState> {
  ListCategoriesBloc({
    required FinansaurusRepository finansaurusRepository,
  })  : _finansaurusRepository = finansaurusRepository,
        super(const ListCategoriesState()) {
    on<ListCategoriesSubscriptionRequested>(_onSubscriptionRequested);
    on<CategoryDeleted>(_onCategoryDeleted);
  }

  final FinansaurusRepository _finansaurusRepository;

  Future<void> _onSubscriptionRequested(
    ListCategoriesSubscriptionRequested event,
    Emitter<ListCategoriesState> emit,
  ) async {
    emit(state.copyWith(status: ListCategoriesStatus.loading));

    await _finansaurusRepository
        .getCategoriesWithoutSystem()
        .then((value) => emit(state.copyWith(
            status: ListCategoriesStatus.success, categories: value)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListCategoriesStatus.failure)));
  }

  Future<void> _onCategoryDeleted(
    CategoryDeleted event,
    Emitter<ListCategoriesState> emit,
  ) async {
    emit(state.copyWith(status: ListCategoriesStatus.loading));

    await _finansaurusRepository
        .deleteCategory(event.category.id ?? 0)
        .then((value) =>
            emit(state.copyWith(status: ListCategoriesStatus.success)))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: ListCategoriesStatus.failure)));
  }
}
