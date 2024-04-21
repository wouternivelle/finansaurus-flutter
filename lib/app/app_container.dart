import 'package:finansaurus_flutter/accounts/list/view/list_accounts_page.dart';
import 'package:finansaurus_flutter/app/bloc/app_bloc.dart';
import 'package:finansaurus_flutter/app/view/app_drawer.dart';
import 'package:finansaurus_flutter/categories/list/view/list_categories_page.dart';
import 'package:finansaurus_flutter/home/view/home_page.dart';
import 'package:finansaurus_flutter/navigation/bloc/navigation_bloc.dart';
import 'package:finansaurus_flutter/payees/list/view/list_payees_page.dart';
import 'package:finansaurus_flutter/transactions/list/view/list_transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<NavigationBloc>(
        create: (BuildContext context) => NavigationBloc(),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, NavigationState state) => Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              title: Text(_getTextForItem(state.selectedItem), style: TextStyle(color: Colors.white)),
              iconTheme: IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.exit_to_app),
                  color: Colors.white,
                  onPressed: () {
                    context.read<AppBloc>().add(const AppLogoutRequested());
                  },
                ),
              ],
            ),
            body: _bodyForState(state.selectedItem),
          ),
        ),
      );

  String _getTextForItem(NavigationItem selectedItem) {
    switch (selectedItem) {
      case NavigationItem.home:
        return 'Home';
      case NavigationItem.payees:
        return 'Payees';
      case NavigationItem.accounts:
        return 'Accounts';
      case NavigationItem.transactions:
        return 'Transactions';
      case NavigationItem.categories:
        return 'Categories';
    }
  }

  _bodyForState(NavigationItem selectedItem) {
    switch (selectedItem) {
      case NavigationItem.home:
        return HomePage();
      case NavigationItem.payees:
        return ListPayeesPage();
      case NavigationItem.accounts:
        return ListAccountsPage();
      case NavigationItem.transactions:
        return ListTransactionsPage();
      case NavigationItem.categories:
        return ListCategoriesPage();
    }
  }
}
