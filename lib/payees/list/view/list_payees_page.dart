import 'package:finansaurus_flutter/payees/edit/bloc/edit_payee_bloc.dart';
import 'package:finansaurus_flutter/payees/edit/view/edit_payee_page.dart';
import 'package:finansaurus_flutter/payees/list/bloc/list_payees_bloc.dart';
import 'package:finansaurus_flutter/payees/list/view/list_payees_tile.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPayeesPage extends StatelessWidget {
  const ListPayeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListPayeesBloc(
        finansaurusRepository: context.read<FinansaurusRepository>(),
      )..add(const ListPayeesSubscriptionRequested()),
      child: const ListPayeesView(),
    );
  }
}

class ListPayeesView extends StatelessWidget {
  const ListPayeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('listPayeesView_addPayee_floatingActionButton'),
        onPressed: () async {
          await Navigator.of(context).push(EditPayeePage.route());
          context.read<ListPayeesBloc>().add(ListPayeesSubscriptionRequested());
        },
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListPayeesBloc, ListPayeesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ListPayeesStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Failed to list the payees'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<ListPayeesBloc, ListPayeesState>(
          builder: (context, state) {
            if (state.payees.isEmpty) {
              if (state.status == ListPayeesStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != ListPayeesStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No payees found',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return Scrollbar(
              child: ListView(
                children: [
                  for (final payee in state.payees)
                    ListPayeesTile(
                      payee: payee,
                      onDismissed: (_) {
                        context.read<ListPayeesBloc>().add(PayeeDeleted(payee));
                      },
                      onTap: () async {
                        await Navigator.of(context).push(
                          EditPayeePage.route(initialPayee: payee),
                        );
                        context
                            .read<ListPayeesBloc>()
                            .add(ListPayeesSubscriptionRequested());
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
