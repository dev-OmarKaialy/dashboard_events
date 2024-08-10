part of 'auth_bloc.dart';

enum CubitStatus { initial, loading, success, failed }

class AuthState {
  final CubitStatus status;
  const AuthState({
    this.status = CubitStatus.initial,
  });

  AuthState copyWith({
    CubitStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
