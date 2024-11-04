import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart';
import 'package:fitnessapp/events/user/user_event.dart';
import 'package:fitnessapp/presentation/state/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserUseCase _userUseCase;
  SignupBloc(this._userUseCase) : super(RegisterInitial()) {
    on<ButtonSubmitPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        UserEntity user =
            await _userUseCase.callSignUp(event.email, event.password, event.fullName, event.age, event.phone);
        emit(RegisterSuccess(user: user));
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
      }
    });
  }
}
