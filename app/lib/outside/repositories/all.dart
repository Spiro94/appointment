import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointments/repository.dart';
import 'auth/repository.dart';
import 'ai/repository.dart';
import 'base.dart';

/// When adding a new repository, be sure to add it to:
/// - [getList]
/// - [createProviders]
///   - Make sure to add the concrete type to `RepositoryProvider<ConcreteType>`
///     otherwise it will register the base class.
class Repositories_All {
  const Repositories_All({
    required this.authRepository,
    required this.aiRepository,
    required this.appointmentsRepository,
  });

  final Auth_Repository authRepository;
  final AI_Repository aiRepository;
  final Appointments_Repository appointmentsRepository;

  List<Repository_Base> getList() => [
    authRepository,
    aiRepository,
    appointmentsRepository,
  ];

  List<RepositoryProvider<Repository_Base>> createProviders() {
    return [
      RepositoryProvider<Auth_Repository>.value(value: authRepository),
      RepositoryProvider<AI_Repository>.value(value: aiRepository),
      RepositoryProvider<Appointments_Repository>.value(
        value: appointmentsRepository,
      ),
    ];
  }

  Future<void> initialize() async {
    await Future.forEach(getList(), (r) async {
      r.log.fine('init');
      await r.init();
    });
  }
}
