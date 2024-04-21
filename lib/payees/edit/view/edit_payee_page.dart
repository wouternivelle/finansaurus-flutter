import 'package:finansaurus_flutter/payees/edit/bloc/edit_payee_bloc.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPayeePage extends StatelessWidget {
  const EditPayeePage({super.key});

  static Route<void> route({Payee? initialPayee}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditPayeeBloc(
          finansaurusRepository: context.read<FinansaurusRepository>(),
          initialPayee: initialPayee,
        ),
        child: const EditPayeePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<EditPayeeBloc, EditPayeeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditPayeeStatus.failure,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Failed to save the payee'),
              ),
            );
        },
      ),
      BlocListener<EditPayeeBloc, EditPayeeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditPayeeStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
      )
    ], child: const EditPayeeView());
  }
}

class EditPayeeView extends StatelessWidget {
  const EditPayeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditPayeeBloc bloc) => bloc.state.status);
    final isNew = context.select(
      (EditPayeeBloc bloc) => bloc.state.isNewPayee,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Create payee' : 'Edit payee'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isNew ? 'Create' : 'Update',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () =>
                context.read<EditPayeeBloc>().add(const EditPayeeSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CircularProgressIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: const Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_NameField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditPayeeBloc>().state;
    final hintText = state.initialPayee?.name ?? '';

    return TextFormField(
      key: const Key('editPayeeView_title_textFormField'),
      initialValue: state.name,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Edit payee',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditPayeeBloc>().add(EditPayeeNameChanged(value));
      },
    );
  }
}
