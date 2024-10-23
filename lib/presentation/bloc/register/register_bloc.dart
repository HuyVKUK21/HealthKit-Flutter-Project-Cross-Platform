import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/usecases/register/register_usecase.dart';
import 'package:fitnessapp/events/register/register_event.dart';
import 'package:fitnessapp/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;


  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        UserEntity user =
            await _registerUseCase.call(event.email, event.password);
        emit(RegisterSuccess(user: user));
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
      }
    });
  }
}
