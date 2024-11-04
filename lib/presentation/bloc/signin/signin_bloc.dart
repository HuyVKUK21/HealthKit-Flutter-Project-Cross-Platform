import 'package:fitnessapp/presentation/events/user/signin_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart';
import 'package:fitnessapp/presentation/state/user/signin_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInBloc extends Bloc<SigninEvent, SigninState> {
  final UserUseCase _userUseCase;

  SignInBloc(this._userUseCase) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<SigninState> emit) async {
    emit(AuthLoading());
    try {
      UserEntity user = await _userUseCase.callSignIn(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(SignInWithGoogleEvent event, Emitter<SigninState> emit) async {
    emit(AuthLoading());
    try {
      UserEntity user = await _userUseCase.callsignInWithGoogle();
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
