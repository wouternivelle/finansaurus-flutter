import 'package:finansaurus_flutter/accounts/edit/view/edit_account_page.dart';
import 'package:finansaurus_flutter/accounts/list/bloc/list_accounts_bloc.dart';
import 'package:finansaurus_flutter/accounts/list/view/list_accounts_tile.dart';
import 'package:finansaurus_flutter/payees/edit/view/edit_payee_page.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListAccountsPage extends StatelessWidget {
  const ListAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListAccountsBloc(
        finansaurusRepository: context.read<FinansaurusRepository>(),
      )..add(const ListAccountsRequested()),
      child: const ListAccountsView(),
    );
  }
}

class ListAccountsView extends StatelessWidget {
  const ListAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('listAccountsView_addAccount_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(EditPayeePage.route()),
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListAccountsBloc, ListAccountsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ListAccountsStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Failed to list the accounts'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<ListAccountsBloc, ListAccountsState>(
          builder: (context, state) {
            if (state.accounts.isEmpty) {
              if (state.status == ListAccountsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != ListAccountsStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No accounts found',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return Scrollbar(
              child: ListView(
                children: [
                  for (final account in state.accounts)
                    ListAccountsTile(
                      account: account,
                      onDismissed: (_) {
                        context
                            .read<ListAccountsBloc>()
                            .add(AccountDeleted(account));
                      },
                      onTap: () async {
                        await Navigator.of(context).push(
                          EditAccountPage.route(initial: account),
                        );
                        context
                            .read<ListAccountsBloc>()
                            .add(ListAccountsRequested());
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
