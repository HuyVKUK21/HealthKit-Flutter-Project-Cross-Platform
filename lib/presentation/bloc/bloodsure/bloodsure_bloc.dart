import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/usecases/bloodsure/get_bloodsure_usecase.dart';
import 'package:fitnessapp/domain/usecases/bloodsure/set_bloodsure_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/check_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/get_weight_usecase.dart';
import 'package:fitnessapp/domain/usecases/weight/set_weight_usecase.dart';
import 'package:fitnessapp/presentation/events/bloodsure/bloodsure_event.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/state/bloodsure/bloodsure_state.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BloodsureBloc extends Bloc<BloodsureEvent, BloodsureState> {
  final SetBloodsureUsecase setBloodsureUsecase;
  final GetBloodsureUsecase getBloodsureUsecase;

  BloodsureBloc(this.setBloodsureUsecase, this.getBloodsureUsecase)
      : super(BloodsureInitial()) {

    on<LoadBloodsureData>((event, emit) async {
      emit(BloodsureLoading());
      try {
        final bloodsureData = await getBloodsureUsecase(event.userId);
        if (bloodsureData != null) {
          emit(BloodsureLoaded(bloodsureData));
        }
        else {
          emit(BloodsureError("No bloodsure data found for this auth."));
        }
      } catch (e) {
        emit(BloodsureError("Failed to load weight data: $e"));
      }
    });

    on<SaveBloodsureData>((event, emit) async {
      emit(BloodsureLoading());
      try {
        final account = await GlobalUtil.getAccount();
        final userId = account?.userId;
        final bloodsureEntity = BloodsureEntity(
          userId: userId ?? '',
          systolic: event.systolic,
          diastolic: event.diastolic,
          heartRate: event.heartRate,
        );
        await setBloodsureUsecase(bloodsureEntity);
        emit(BloodsureUpdated());
      } catch (e) {
        emit(BloodsureError("Failed to save bloodsure and height data: $e"));
      }
    });

  }
}
