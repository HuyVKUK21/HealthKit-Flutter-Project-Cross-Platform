class WeightEntity {
  final String userId;
  final double? currentWeight;
  final DateTime? targetWeightDate;
  final double? weightGoal;
  final String? paceGoal;
  final int? weightsPerWeekGoal;
  final String? selectedTimeUnit;
  final double? height;
  final double? bmi;

  WeightEntity({
    required this.userId,
    this.currentWeight,
    this.targetWeightDate,
    this.weightGoal,
    this.paceGoal,
    this.weightsPerWeekGoal,
    this.selectedTimeUnit,
    this.height,
    this.bmi,
  });


  @override
  String toString() {
    return 'WeightEntity{userId: $userId, currentWeight: $currentWeight, targetWeightDate: $targetWeightDate, weightGoal: $weightGoal, paceGoal: $paceGoal, weightsPerWeekGoal: $weightsPerWeekGoal, selectedTimeUnit: $selectedTimeUnit, height: $height, bmi: $bmi}';
  }

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
