import 'package:authentication_repository/authentication_repository.dart';
import 'package:finansaurus_flutter/app/app_container.dart';
import 'package:finansaurus_flutter/app/bloc/app_bloc.dart';
import 'package:finansaurus_flutter/login/login.dart';
import 'package:finansaurus_flutter/theme.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required FinansaurusRepository finansaurusRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _finansaurusRepository = finansaurusRepository;

  final AuthenticationRepository _authenticationRepository;
  final FinansaurusRepository _finansaurusRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (BuildContext context) => _authenticationRepository,
        ),
        RepositoryProvider<FinansaurusRepository>(
          create: (BuildContext context) => _finansaurusRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    var appStatus = context.select((AppBloc bloc) => bloc.state.status);

    var page;
    switch (appStatus) {
      case AppStatus.authenticated:
        page = new AppContainer();
        break;
      case AppStatus.unauthenticated:
        page = new LoginPage();
        break;
    }

    return MaterialApp(theme: theme, home: page);
  }
}
