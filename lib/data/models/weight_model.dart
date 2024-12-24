import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';

class WeightModel extends WeightEntity {
  WeightModel({
    required String userId,
    double? currentWeight,
    DateTime? targetWeightDate,
    double? weightGoal,
    String? paceGoal,
    int? weightsPerWeekGoal,
    String? selectedTimeUnit,
    double? height,
    double? bmi,
  }) : super(
    userId: userId,
    currentWeight: currentWeight,
    targetWeightDate: targetWeightDate,
    weightGoal: weightGoal,
    paceGoal: paceGoal,
    weightsPerWeekGoal: weightsPerWeekGoal,
    selectedTimeUnit: selectedTimeUnit,
    height: height,
    bmi: bmi,
  );

  factory WeightModel.fromEntity(WeightEntity entity) {
    return WeightModel(
      userId: entity.userId,
      currentWeight: entity.currentWeight,
      targetWeightDate: entity.targetWeightDate,
      weightGoal: entity.weightGoal,
      paceGoal: entity.paceGoal,
      weightsPerWeekGoal: entity.weightsPerWeekGoal,
      selectedTimeUnit: entity.selectedTimeUnit,
      height: entity.height,
      bmi: entity.bmi,
    );
  }

  // Phương thức chuyển đổi từ WeightModel về WeightEntity
  WeightEntity toEntity() {
    return WeightEntity(
      userId: userId,
      currentWeight: currentWeight,
      targetWeightDate: targetWeightDate,
      weightGoal: weightGoal,
      paceGoal: paceGoal,
      weightsPerWeekGoal: weightsPerWeekGoal,
      selectedTimeUnit: selectedTimeUnit,
      height: height,
      bmi: bmi,
    );
  }

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      userId: json['userId'] ?? '',
      currentWeight: json['currentWeight'] ?? 0.0,
      targetWeightDate: json['targetWeightDate'] != null
          ? (json['targetWeightDate'] as Timestamp).toDate()
          : null,
      weightGoal: json['weightGoal'] != null ? json['weightGoal'] : null,
      paceGoal: json['paceGoal'],
      weightsPerWeekGoal: json['weightsPerWeekGoal'],
      selectedTimeUnit: json['selectedTimeUnit'],
      height: json['height'] ?? 0.0,
      bmi: json['bmi'] ?? 0.0,
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentWeight': currentWeight,
      'targetWeightDate': targetWeightDate?.toIso8601String(),
      'weightGoal': weightGoal,
      'paceGoal': paceGoal,
      'weightsPerWeekGoal': weightsPerWeekGoal,
      'selectedTimeUnit': selectedTimeUnit,
      'height': height,
      'bmi': bmi,
    };
  }
}
