import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(NavigationItem.home)) {
    on<NavigatedTo>(_onNavigatedTo);
  }

  void _onNavigatedTo(NavigatedTo event, Emitter<NavigationState> emit) {
    if (event.destination != state.selectedItem) {
      emit(NavigationState(event.destination));
    }
  }
}
