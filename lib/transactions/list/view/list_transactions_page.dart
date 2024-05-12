import 'package:finansaurus_flutter/transactions/list/bloc/list_transactions_bloc.dart';
import 'package:finansaurus_flutter/transactions/list/view/list_transactions_tile.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTransactionsPage extends StatelessWidget {
  const ListTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListTransactionsBloc(
        finansaurusRepository: context.read<FinansaurusRepository>(),
      )..add(const ListTransactionsSubscriptionRequested()),
      child: const ListTransactionsView(),
    );
  }
}

class ListTransactionsView extends StatelessWidget {
  const ListTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key(
            'listTransactionsView_addTransaction_floatingActionButton'),
        onPressed: () => (),
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListTransactionsBloc, ListTransactionsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ListTransactionsStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Failed to list the categories'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<ListTransactionsBloc, ListTransactionsState>(
          builder: (context, state) {
            if (state.transactions.isEmpty) {
              if (state.status == ListTransactionsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != ListTransactionsStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No transactions found',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return Scrollbar(
              child: ListView(
                children: [
                  for (final transaction in state.transactions)
                    ListTransactionsTile(
                      transaction: transaction,
                      onDismissed: (_) {
                        context
                            .read<ListTransactionsBloc>()
                            .add(TransactionDeleted(transaction));
                        context.read<ListTransactionsBloc>().add(ListTransactionsSubscriptionRequested());
                      },
                      onTap: () async {
                        //await Navigator.of(context).push(
                        //EditPayeePage.route(initialPayee: category),
                        //);
                        //context.read<ListPayeesBloc>().add(ListPayeesSubscriptionRequested());
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
