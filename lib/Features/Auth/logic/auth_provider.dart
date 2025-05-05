import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/Auth/data/auth_repository.dart';
import 'package:onay/shared/utils/session_provider.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthInitial());

Future<void> login(String code) async {
  state = AuthLoading();

  final repo = ref.read(authRepositoryProvider);
  final role = await repo.login(code);

  if (role != null) {
    ref.read(sessionProvider.notifier).state = code; // сохранили sessionId
    state = AuthSuccess(role, code);
  } else {
    state = AuthError("Неверный код");
  }
}
}
