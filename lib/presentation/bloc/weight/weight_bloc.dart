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

  WeightBloc(this.getWeightUseCase, this.setWeightUseCase)
      : super(WeightInitial()) {
    on<LoadWeightData>((event, emit) async {
      emit(WeightLoading());
      try {
        final weightData = await getWeightUseCase(event.userId);
        if (weightData != null) {
          emit(WeightLoaded(weightData));
        }
        else {
          emit(WeightError("No weight data found for this auth."));
        }
      } catch (e) {
        emit(WeightError("Failed to load weight data: $e"));
      }
    });

    on<SaveWeightHeightData>((event, emit) async {
      emit(WeightLoading());
      try {
        final account = await GlobalUtil.getAccount();
        final userId = account?.userId;
        final bmi = event.weight / ((event.height / 100) * (event.height / 100));
        final weightEntity = WeightEntity(
          userId: userId ?? '',
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


    on<SaveWeightGoalData>((event, emit) async {
      emit(WeightLoading());
      try {
        final account = await GlobalUtil.getAccount();
        final userId = account?.userId;
        final weightEntity = WeightEntity(
          userId: userId ?? '',
          weightGoal: event.weightGoal,
          paceGoal: event.paceGoal,
          weightsPerWeekGoal: event.weightsPerWeek,
          selectedTimeUnit: event.selectedTimeUnit,
        );
        await setWeightUseCase(weightEntity);
        emit(WeightUpdated());
      } catch (e) {
        emit(WeightError("Failed to save weight and height data: $e"));
      }
    });
  }
}
