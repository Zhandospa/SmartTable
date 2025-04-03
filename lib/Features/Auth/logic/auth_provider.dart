import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../data/repository.dart';
import 'auth_state.dart';

final logger = Logger();

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthInitial()){
    logger.i("Приложение запущено, начальное состояние:$AuthInitial");
  }

  Future<void> login(String password) async {
    state = AuthLoading();
    logger.i("Пользватель вводит пароль");

    try {
      final succes = await _authRepository.login(password);
      if(succes){
        state = AuthSuccess();
        logger.i("Auth Succes");
      }else{
        state = AuthError("Неправильный пароль");
        logger.w("Ошибка:Неправильный пароль");
      }

      }catch(e){
      state = AuthError("Ошибка сети: $e");
      logger.e("Ошибка сети: $e");
    }
  }
}
