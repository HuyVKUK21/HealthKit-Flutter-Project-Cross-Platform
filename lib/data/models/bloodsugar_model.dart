import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';

class BloodsugarModel extends BloodsugarEntity {
  BloodsugarModel({
    required String userId,
    required double index,
    required String status,
    String? statusMeasure,
    DateTime? dateTime,
    int? measurementFrequency,
  }) : super(
      userId: userId,
      index: index,
      status: status,
      statusMeasure: statusMeasure,
      dateTime: dateTime,
      measurementFrequency: measurementFrequency
  );

  factory BloodsugarModel.fromEntity(BloodsugarEntity entity) {
    return BloodsugarModel(
      userId: entity.userId,
      index: entity.index,
      status: entity.status,
      statusMeasure: entity.statusMeasure,
      dateTime: entity.dateTime,
      measurementFrequency: entity.measurementFrequency,
    );
  }

  // Phương thức chuyển đổi từ WeightModel về WeightEntity
  BloodsugarEntity toEntity() {
    return BloodsugarModel(
      userId: userId,
      index: index,
      status: status,
      dateTime: dateTime,
      statusMeasure: statusMeasure,
      measurementFrequency: measurementFrequency,
    );
  }

  factory BloodsugarModel.fromJson(Map<String, dynamic> json) {
    return BloodsugarModel(
      userId: json['userId'],
      index: json['index'],
      status: json['status'],
      statusMeasure: json['statusMeasure'],
      dateTime: json['dateTime'] is Timestamp
          ? (json['dateTime'] as Timestamp).toDate()
          : null,
      measurementFrequency: json['measurementFrequency'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'index': index,
      'status': status,
      'statusMeasure': statusMeasure,
      'dateTime': dateTime,
      'measurementFrequency': measurementFrequency
    };
  }
}
