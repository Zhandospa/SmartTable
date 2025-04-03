

class AuthService {

  static bool isLoggedIn({bool? override}) {
    if (override != null) {
      return override;
    }
    // Здесь будет реальная проверка (например, через API или локальное хранилище)
    return false; // Пока что всегда false
  }
  // static Future<bool> login(String password) async {
  //   final token = await _authRepository.login(password);
  //   return false;
  // } TODO at home
}
