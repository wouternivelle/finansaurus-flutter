import 'package:authentication_repository/authentication_repository.dart';
import 'package:finansaurus_flutter/home/widgets/avatar.dart';
import 'package:finansaurus_flutter/navigation/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(NavigationItem.home, "Home", Icons.home),
    _NavigationItem(NavigationItem.transactions, "Transactions", Icons.money),
    _NavigationItem(NavigationItem.categories, "Categories", Icons.list),
    _NavigationItem(NavigationItem.payees, "Payees", Icons.people),
    _NavigationItem(NavigationItem.accounts, "Accounts", Icons.warehouse),
  ];

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    children.add(_makeHeaderItem(
        context.read<AuthenticationRepository>().currentUser,
        Theme.of(context)));
    children.addAll(_listItems.map((e) => _makeListItem(
        e, context.read<NavigationBloc>().state, Theme.of(context))));

    return Drawer(
        child: Container(
            child: ListView(
      children: children,
    )));
  }

  Widget _makeHeaderItem(User user, ThemeData theme) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.name ?? ''),
      accountEmail: Text(user.email ?? ''),
      decoration: BoxDecoration(color: theme.appBarTheme.backgroundColor),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber,
        child: Avatar(photo: user.photo),
      ),
    );
  }

  Widget _makeListItem(
          _NavigationItem data, NavigationState state, ThemeData theme) =>
      Card(
        color: data.item == state.selectedItem
            ? theme.colorScheme.secondary
            : Colors.white,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        // So we see the selected highlight
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                color: data.item == state.selectedItem
                    ? Colors.white
                    : Colors.blueGrey,
              ),
            ),
            leading: Icon(
              data.icon,
              // if it's selected change the color
              color: data.item == state.selectedItem
                  ? Colors.white
                  : Colors.blueGrey,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavigationItem item) {
    BlocProvider.of<NavigationBloc>(context).add(NavigatedTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final NavigationItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.item, this.title, this.icon);
}
