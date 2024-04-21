part of 'navigation_bloc.dart';

sealed class NavigationEvent {
  const NavigationEvent();
}

final class NavigatedTo extends NavigationEvent {
  final NavigationItem destination;
  const NavigatedTo(this.destination);
}