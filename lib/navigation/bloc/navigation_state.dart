part of 'navigation_bloc.dart';

class NavigationState {
  final NavigationItem selectedItem;
  const NavigationState(this.selectedItem);
}

enum NavigationItem {
  home,
  transactions,
  categories,
  payees,
  accounts
}