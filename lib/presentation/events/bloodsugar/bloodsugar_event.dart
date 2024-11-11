import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';


abstract class BloodsugarEvent {}

class LoadBloodsugarData extends BloodsugarEvent {
  final String userId;

  LoadBloodsugarData(this.userId);
}

class UpdateBloodsugarData extends BloodsugarEvent {
  final BloodsugarEntity bloodsugarEntity;
  UpdateBloodsugarData(this.bloodsugarEntity);
}



class SaveBloodsugarData extends BloodsugarEvent {
  final double index;
  final String status;
  // final String statusMeasure;

  SaveBloodsugarData({
    required this.index,
    required this.status,
    // required this.statusMeasure
  });
}
