import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:finansaurus_http_api/finansaurus_http_api.dart';
import 'package:finansaurus_repository/finansaurus_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'app/bloc_observer.dart';
import 'app/view/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final finansaurusRepository =
      FinansaurusRepository(finansaurusApi: new FinansaurusHttpApi(baseUrl: const String.fromEnvironment('FINANSAURUS_BASE_URL')));

  runApp(App(
    authenticationRepository: authenticationRepository,
    finansaurusRepository: finansaurusRepository,
  ));
}
