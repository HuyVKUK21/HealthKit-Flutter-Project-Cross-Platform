import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/usecases/bloodsugar/get_bloodsugar_usecase.dart';
import 'package:fitnessapp/domain/usecases/bloodsugar/set_bloodsugar_usecase.dart';
import 'package:fitnessapp/domain/usecases/bloodsure/get_bloodsure_usecase.dart';
import 'package:fitnessapp/domain/usecases/bloodsure/set_bloodsure_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/check_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/get_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/set_weight_usecase.dart';
import 'package:fitnessapp/presentation/events/bloodsugar/bloodsugar_event.dart';
import 'package:fitnessapp/presentation/events/bloodsure/bloodsure_event.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/state/bloodsugar/bloodsugar_state.dart';
import 'package:fitnessapp/presentation/state/bloodsure/bloodsure_state.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BloodsugarBloc extends Bloc<BloodsugarEvent, BloodsugarState> {
  final SetBloodsugarUsecase setBloodsugarUsecase;
  final GetBloodsugarUsecase getBloodsugarUsecase;

  BloodsugarBloc(this.setBloodsugarUsecase, this.getBloodsugarUsecase) : super(BloodsugarInitial()) {

    on<LoadBloodsugarData>((event, emit) async {
      emit(BloodsugarLoading());
      try {
        final bloodsureData = await getBloodsugarUsecase(event.userId);
        if (bloodsureData != null) {
          emit(BloodsugarLoaded(bloodsureData));
        }
        else {
          emit(BloodsugarError("No bloodsugar data found for this auth."));
        }
      } catch (e) {
        emit(BloodsugarError("Failed to load bloodsugar data: $e"));
      }
    });

    on<SaveBloodsugarData>((event, emit) async {
      emit(BloodsugarLoading());
      try {
        final account = await GlobalUtil.getAccount();
        final userId = account?.userId;
        final bloodsugarEntity = BloodsugarEntity(
          userId: userId ?? '',
          index: event.index,
          status: event.status,
          dateTime: DateTime.now(),
        );
        await setBloodsugarUsecase(bloodsugarEntity);
        emit(BloodsugarUpdated());
      } catch (e) {
        emit(BloodsugarError("Failed to save bloodsugar and height data: $e"));
      }
    });

  }
}
