import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:events_dashboard/core/utils/toaster.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>((event, emit) async {
      try {
        Toaster.showLoading();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        FirebaseAuth.instance.authStateChanges();
        Toaster.closeLoading();
        emit(state.copyWith(status: CubitStatus.success));
      } on FirebaseAuthException catch (e) {
        Toaster.closeLoading();
        Toaster.showToast(e.message ?? '');
      } on Exception catch (e) {
        Toaster.closeLoading();
      }
    });
  }
}
