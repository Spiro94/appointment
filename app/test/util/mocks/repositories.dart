import 'package:appointment/outside/repositories/ai/repository.dart';
import 'package:appointment/outside/repositories/auth/repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements Auth_Repository {}

class MockAIRepository extends Mock implements AI_Repository {}
