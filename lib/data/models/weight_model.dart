import 'package:fitnessapp/domain/entities/weight_entity.dart';

class WeightModel extends WeightEntity {
  WeightModel({
    required String userId,
    required double currentWeight,
    double? targetWeight,
    DateTime? targetWeightDate,
    String? measurementFrequency,
    double? height,
    double? bmi,
  }) : super(
    userId: userId,
    currentWeight: currentWeight,
    targetWeight: targetWeight,
    targetWeightDate: targetWeightDate,
    measurementFrequency: measurementFrequency,
    height: height,
    bmi: bmi,
  );

  factory WeightModel.fromEntity(WeightEntity entity) {
    return WeightModel(
      userId: entity.userId,
      currentWeight: entity.currentWeight,
      targetWeight: entity.targetWeight,
      targetWeightDate: entity.targetWeightDate,
      measurementFrequency: entity.measurementFrequency,
      height: entity.height,
      bmi: entity.bmi,
    );
  }

  // Phương thức chuyển đổi từ WeightModel về WeightEntity
  WeightEntity toEntity() {
    return WeightEntity(
      userId: userId,
      currentWeight: currentWeight,
      targetWeight: targetWeight,
      targetWeightDate: targetWeightDate,
      measurementFrequency: measurementFrequency,
      height: height,
      bmi: bmi,
    );
  }

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      userId: json['userId'],
      currentWeight: json['currentWeight'],
      targetWeight: json['targetWeight'],
      targetWeightDate: json['targetWeightDate'] != null
          ? DateTime.parse(json['targetWeightDate'])
          : null,
      measurementFrequency: json['measurementFrequency'],
      height: json['height'],
      bmi: json['bmi'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentWeight': currentWeight,
      'targetWeight': targetWeight,
      'targetWeightDate': targetWeightDate?.toIso8601String(),
      'measurementFrequency': measurementFrequency,
      'height': height,
      'bmi': bmi,
    };
  }
}
