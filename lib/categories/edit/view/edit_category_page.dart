import 'package:finansaurus_flutter/categories/edit/bloc/edit_category_bloc.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({super.key});

  static Route<void> route(
      {Category? initial, required List<Category> categories}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditCategoryBloc(
            finansaurusRepository: context.read<FinansaurusRepository>(),
            initial: initial,
            parentCategories: categories
                .where((category) => category.parent == null)
                .where((category) => category.id != initial?.id)
                .toList()),
        child: const EditCategoryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<EditCategoryBloc, EditCategoryState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditCategoryStatus.failure,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Failed to save the category'),
              ),
            );
        },
      ),
      BlocListener<EditCategoryBloc, EditCategoryState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditCategoryStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
      )
    ], child: const EditCategoryView());
  }
}

class EditCategoryView extends StatelessWidget {
  const EditCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditCategoryBloc bloc) => bloc.state.status);
    final isNew = context.select(
      (EditCategoryBloc bloc) => bloc.state.isNew,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Create category' : 'Edit category'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isNew ? 'Create' : 'Update',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context
                .read<EditCategoryBloc>()
                .add(const EditCategorySubmitted()),
        child: status.isLoadingOrSuccess
            ? const CircularProgressIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_NameField(), SizedBox(height: 25.0), _ParentField()],
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
    final state = context.watch<EditCategoryBloc>().state;
    final hintText = state.initial?.name ?? '';

    return TextFormField(
      key: const Key('editCategoryView_name_textFormField'),
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
        context.read<EditCategoryBloc>().add(EditCategoryNameChanged(value));
      },
    );
  }
}

class _ParentField extends StatelessWidget {
  const _ParentField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCategoryBloc>().state;
    final List<DropdownMenuItem<int?>> menuItems = [
      new DropdownMenuItem(value: null, child: Text(''))
    ];
    menuItems.addAll(state.parentCategories
        .map((parent) =>
            new DropdownMenuItem(value: parent.id, child: Text(parent.name)))
        .toList());

    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabled: !state.status.isLoadingOrSuccess,
          labelText: 'Parent',
        ),
        items: menuItems,
        value: state.parent,
        onChanged: (value) {
          context
              .read<EditCategoryBloc>()
              .add(EditCategoryParentChanged(value));
        });
  }
}
