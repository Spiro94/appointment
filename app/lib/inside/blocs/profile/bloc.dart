import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/auth/repository.dart';
import '../../../shared/mixins/logging.dart';
import 'event.dart';
import 'state.dart';

class Profile_Bloc extends Bloc<Profile_Event, Profile_State>
    with SharedMixin_Logging {
  Profile_Bloc({required this.authRepository}) : super(const Profile_State()) {
    on<Profile_Event_LoadUserData>(_onLoadUserData);
    on<Profile_Event_SignOut>(_onSignOut);

    // Load user data on initialization
    add(const Profile_Event_LoadUserData());
  }

  final Auth_Repository authRepository;

  Future<void> _onLoadUserData(
    Profile_Event_LoadUserData event,
    Emitter<Profile_State> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Get current user information
      final user = authRepository.getCurrentUser();
      final userName = (await user)?.email ?? 'User';

      emit(state.copyWith(userName: userName, isLoading: false));
    } catch (error, stackTrace) {
      log.warning('Failed to load user data', error, stackTrace);
      emit(state.copyWith(userName: 'User', isLoading: false));
    }
  }

  Future<void> _onSignOut(
    Profile_Event_SignOut event,
    Emitter<Profile_State> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await authRepository.signOut();
      // The auth state change will be handled by the Auth_Bloc
    } catch (error, stackTrace) {
      log.warning('Failed to sign out', error, stackTrace);
      emit(state.copyWith(isLoading: false));
    }
  }
}
