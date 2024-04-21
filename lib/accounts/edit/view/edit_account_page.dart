import 'package:finansaurus_flutter/accounts/edit/bloc/edit_account_bloc.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});

  static Route<void> route({Account? initial}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditAccountBloc(
          finansaurusRepository: context.read<FinansaurusRepository>(),
          initial: initial,
        ),
        child: const EditAccountPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<EditAccountBloc, EditAccountState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditAccountStatus.failure,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Failed to save the account'),
              ),
            );
        },
      ),
      BlocListener<EditAccountBloc, EditAccountState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditAccountStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
      )
    ], child: const EditAccountView());
  }
}

class EditAccountView extends StatelessWidget {
  const EditAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditAccountBloc bloc) => bloc.state.status);
    final isNew = context.select(
      (EditAccountBloc bloc) => bloc.state.isNew,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Create account' : 'Edit account'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isNew ? 'Create' : 'Update',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context
                .read<EditAccountBloc>()
                .add(const EditAccountSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CircularProgressIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: _fields(isNew),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _fields(bool isNew) {
    final paddingHeight = 25.0;
    final fields = [
      _NameField(),
      SizedBox(
        height: paddingHeight,
      )
    ];
    if (!isNew) {
      fields.addAll([
        _AmountField(),
        SizedBox(
          height: paddingHeight,
        )
      ]);
    }
    fields.addAll([
      _TypeField(),
      SizedBox(
        height: paddingHeight,
      ),
      _StarredField(),
    ]);
    return fields;
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditAccountBloc>().state;
    final hintText = state.initial?.name ?? '';

    return TextFormField(
      key: const Key('editAccountView_name_textFormField'),
      initialValue: state.name,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Name',
        hintText: hintText,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditAccountBloc>().add(EditAccountNameChanged(value));
      },
    );
  }
}

class _TypeField extends StatelessWidget {
  const _TypeField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditAccountBloc>().state;

    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabled: !state.status.isLoadingOrSuccess,
          labelText: 'Type',
        ),
        items: AccountType.values
            .map((type) =>
                new DropdownMenuItem(value: type.name, child: Text(type.name)))
            .toList(),
        value: state.type.name,
        onChanged: (value) {
          context
              .read<EditAccountBloc>()
              .add(EditAccountTypeChanged(AccountType.of(value)));
        });
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditAccountBloc>().state;

    return TextFormField(
      key: const Key('editAccountView_amount_textFormField'),
      initialValue: state.amount.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Amount',
        hintText: '0',
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      onChanged: (value) {
        context.read<EditAccountBloc>().add(EditAccountNameChanged(value));
      },
    );
  }
}

class _StarredField extends StatelessWidget {
  const _StarredField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditAccountBloc>().state;
    return SwitchListTile(
      title: Text('Starred'),
      value: state.starred,
      onChanged: (bool value) {
        context.read<EditAccountBloc>().add(EditAccountStarredChanged(value));
      },
    );
  }
}
