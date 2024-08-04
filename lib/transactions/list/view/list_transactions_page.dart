import 'dart:developer';

import 'package:finansaurus_flutter/transactions/list/bloc/list_transactions_bloc.dart';
import 'package:finansaurus_flutter/transactions/list/view/list_transactions_tile.dart';
import 'package:finansaurus_flutter/widget/bottom_loader.dart';
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

class ListTransactionsView extends StatefulWidget {
  const ListTransactionsView({super.key});

  @override
  State<ListTransactionsView> createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactionsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
                    const SnackBar(
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

            log('TRANSACTION LENGTH IS ${state.transactions.length}');

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.transactions.length
                    ? const BottomLoader()
                    : ListTransactionsTile(
                        transaction: state.transactions[index],
                        categories: state.categories,
                        payees: state.payees,
                        onDismissed: (_) {
                          context.read<ListTransactionsBloc>().add(
                              TransactionDeleted(state.transactions[index]));
                          context.read<ListTransactionsBloc>().add(
                              const ListTransactionsSubscriptionRequested());
                        },
                        onTap: () async {
                          //await Navigator.of(context).push(
                          //EditPayeePage.route(initialPayee: category),
                          //);
                          //context.read<ListPayeesBloc>().add(ListPayeesSubscriptionRequested());
                        },
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.transactions.length
                  : state.transactions.length + 1,
              controller: _scrollController,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ListTransactionsBloc>().add(TransactionsNeeded());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
