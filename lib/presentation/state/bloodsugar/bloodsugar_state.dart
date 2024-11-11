import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';


abstract class BloodsugarState {}

class BloodsugarInitial extends BloodsugarState {}

class BloodsugarLoading extends BloodsugarState {}

class BloodsugarLoaded extends BloodsugarState {
  final BloodsugarEntity bloodsugarEntity;

  BloodsugarLoaded(this.bloodsugarEntity);
}

class BloodsugarUpdated extends BloodsugarState {}

class BloodsugarError extends BloodsugarState {
  final String message;

  BloodsugarError(this.message);
}

class BloodsugarDataExists extends BloodsugarState {}
class BloodsugarDataNotFound extends BloodsugarState {}

