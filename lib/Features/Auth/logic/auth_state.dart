abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String role;
  final String sessionId;

  AuthSuccess(this.role, this.sessionId);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
