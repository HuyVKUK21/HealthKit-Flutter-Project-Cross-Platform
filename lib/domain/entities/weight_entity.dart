class WeightEntity {
  final String userId;
  final double currentWeight;
  final double? targetWeight;
  final DateTime? targetWeightDate;
  final String? measurementFrequency;
  final double? height;
  final double? bmi;

  WeightEntity({
    required this.userId,
    required this.currentWeight,
    this.targetWeight,
    this.targetWeightDate,
    this.measurementFrequency,
    this.height,
    this.bmi,
  });

  @override
  String toString() {
    return 'WeightEntity(userId: $userId, currentWeight: $currentWeight, targetWeight: $targetWeight, targetWeightDate: $targetWeightDate, measurementFrequency: $measurementFrequency, height: $height, bmi: $bmi)';
  }

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
