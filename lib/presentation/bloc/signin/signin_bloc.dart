import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart';
import 'package:fitnessapp/events/user/user_event.dart';
import 'package:fitnessapp/presentation/state/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserUseCase _userUseCase;
  SignInBloc(this._userUseCase) : super(RegisterInitial()) {
    on<ButtonSubmitPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        UserEntity user =
        await _userUseCase.callSignIn(event.email, event.password);
        emit(RegisterSuccess(user: user));
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
      }
    });

    on<GoogleSignInPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        UserEntity user = await _userUseCase.callsignInWithGoogle();
        emit(RegisterSuccess(user: user));
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
        print(error.toString());
      }
    });
  }
}
