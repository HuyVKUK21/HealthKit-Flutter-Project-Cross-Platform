import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/usecases/weight/check_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/get_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/set_weight_usecase.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WeightBloc extends Bloc<WeightEvent, WeightState> {
  final GetWeightUsecase getWeightUseCase;
  final SetWeightUsecase setWeightUseCase;
  // final CheckWeightUsecase checkWeightUsecase;

  WeightBloc(this.getWeightUseCase, this.setWeightUseCase)
      : super(WeightInitial()) {

    on<LoadWeightData>((event, emit) async {
      emit(WeightLoading());
      try {
        final weightData = await getWeightUseCase(event.userId);
        if (weightData != null) {
          emit(WeightLoaded(weightData));
        } else {
          emit(WeightError("No weight data found for this user."));
        }
      } catch (e) {
        emit(WeightError("Failed to load weight data: $e"));
      }
    });

    on<SaveWeightHeightData>((event, emit) async {
      emit(WeightLoading());
      try {
        final userId = await GlobalUtil.getUserId();
        final bmi = event.weight / ((event.height / 100) * (event.height / 100));
        final weightEntity = WeightEntity(
          userId: userId ?? '', // Get from GlobalUtil or authentication logic
          currentWeight: event.weight,
          height: event.height,
          bmi: bmi,
        );
        await setWeightUseCase(weightEntity);
        emit(WeightUpdated());
      } catch (e) {
        emit(WeightError("Failed to save weight and height data: $e"));
      }
    });

  }
}
