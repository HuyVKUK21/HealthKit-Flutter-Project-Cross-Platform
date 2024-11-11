import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';

class BloodsureModel extends BloodsureEntity {
  BloodsureModel({
    required String userId,
    required int systolic,
    required int diastolic,
    required int heartRate,
    DateTime? dateTime,
    int? measurementFrequency,
  }) : super(
      userId: userId,
      systolic: systolic,
      diastolic: diastolic,
      heartRate: heartRate,
      dateTime: dateTime,
      measurementFrequency: measurementFrequency
  );

  factory BloodsureModel.fromEntity(BloodsureEntity entity) {
    return BloodsureModel(
      userId: entity.userId,
      systolic: entity.systolic,
      diastolic: entity.diastolic,
      heartRate: entity.heartRate,
      dateTime: entity.dateTime,
      measurementFrequency: entity.measurementFrequency,
    );
  }

  // Phương thức chuyển đổi từ WeightModel về WeightEntity
  BloodsureEntity toEntity() {
    return BloodsureModel(
      userId: userId,
      systolic: systolic,
      diastolic: diastolic,
      heartRate: heartRate,
      dateTime: dateTime,
      measurementFrequency: measurementFrequency,
    );
  }

  factory BloodsureModel.fromJson(Map<String, dynamic> json) {
    return BloodsureModel(
      userId: json['userId'],
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      heartRate: json['heartRate'],
      dateTime: json['dateTime'],
      measurementFrequency: json['measurementFrequency'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'systolic': systolic,
      'diastolic': diastolic,
      'heartRate': heartRate,
      'dateTime': dateTime,
      'measurementFrequency': measurementFrequency
    };
  }
}
