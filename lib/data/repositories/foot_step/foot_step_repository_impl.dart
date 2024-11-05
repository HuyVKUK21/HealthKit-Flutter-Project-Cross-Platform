import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/meansure_foot_step.dart';
import 'package:fitnessapp/domain/repositories/foot_step/foot_step_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FootStepRepository)
class FootStepRepositoryImpl extends FootStepRepository {
  final CollectionReference _footStepCollection =
      FirebaseFirestore.instance.collection('footSteps');
  @override
  Future<FootStepModel?> getFootStepByIdUser(String id) async {
    final CollectionReference footStepCollection =
        FirebaseFirestore.instance.collection('footSteps');

    try {
      QuerySnapshot querySnapshot =
          await footStepCollection.where('userId', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs[0];
        final data = doc.data() as Map<String, dynamic>;

        FootStepModel model = FootStepModel(
          userId: data['userId'] ?? '',
          aim: data['aim'] ?? 0,
          stepOfDay: (data['stepOfDay'] as List<dynamic>?)?.map((item) {
                String date = item['date'] ?? '';
                int step = item['step'] ?? 0;
                return StepOfDay(date: date, step: step);
              }).toList() ??
              [],
        );
        return model;
      } else {
        StepOfDay newStepOfToday = StepOfDay(
            date:
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            step: 0);
        FootStepModel newModel = FootStepModel(
          userId: id,
          aim: 0, // Có thể thay đổi giá trị này nếu cần
          stepOfDay: [newStepOfToday], // Khởi tạo mảng trống
        );

        // Lưu tài liệu mới vào Firestore
        await footStepCollection
            .add(newModel.toMap()); // Gọi hàm toMap() để chuyển đổi sang Map

        print("Created new FootStepModel for user ID: $id");
        return newModel;
      }
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }

  @override
  Future<void> updateAimByIdUser(String id, int aim) async {
    try {
      QuerySnapshot querySnapshot =
          await _footStepCollection.where('userId', isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;

        await _footStepCollection.doc(doc.id).update({
          'aim': aim,
        });

        print('Aim đã được cập nhật thành công!');
      } else {
        print('Không tìm thấy document nào với idUser: $id');
      }
    } catch (e) {
      print('Lỗi khi cập nhật aim: $e');
    }
  }

  @override
  Future<void> updateFootStepByIdUser(
      String id, List<Map<String, dynamic>> stepOfDays) async {
    try {
      QuerySnapshot querySnapshot =
          await _footStepCollection.where('userId', isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;

        await _footStepCollection.doc(doc.id).update({
          'stepOfDay': stepOfDays,
        });

        print('StepOfDays đã được cập nhật thành công!');
      } else {
        print('Không tìm thấy document nào với idUser: $id');
      }
    } catch (e) {
      print('Lỗi khi cập nhật StepOfDays: $e');
    }
  }

  @override
  Future<StepOfDay> updateStepOfDayWhenStopByIdUser(
      String id, StepOfDay stepOfDay) async {
    try {
      // Tìm document trong Firestore dựa vào `idUser`
      QuerySnapshot querySnapshot =
          await _footStepCollection.where('userId', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Lấy document đầu tiên trong danh sách kết quả
        DocumentSnapshot doc = querySnapshot.docs.first;

        // Tạo đối tượng FootStepModel từ dữ liệu trong document
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> stepOfDayData = data['stepOfDay'] ?? [];

        List<StepOfDay> stepOfDays = stepOfDayData.map((item) {
          return StepOfDay(
            date: item['date'],
            step: item['step'],
          );
        }).toList();

        String today =
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
        bool updated = false;

        StepOfDay updatedStepOfDay =
            StepOfDay(date: today, step: stepOfDay.step);

        for (var i = 0; i < stepOfDays.length; i++) {
          if (stepOfDays[i].date == today) {
            updatedStepOfDay = StepOfDay(date: today, step: stepOfDay.step);
            stepOfDays[i] = updatedStepOfDay;
            updated = true;
            break;
          }
        }

        if (!updated) {
          updatedStepOfDay = StepOfDay(date: today, step: stepOfDay.step);
          stepOfDays.add(updatedStepOfDay);
        }

        await _footStepCollection.doc(doc.id).update({
          'stepOfDay': stepOfDays
              .map((step) => {
                    'date': step.date,
                    'step': step.step,
                  })
              .toList(),
        });

        print('StepOfDays đã được cập nhật thành công!');

        // Trả về `StepOfDay` đã được cập nhật hoặc thêm mới
        return updatedStepOfDay;
      } else {
        print('Không tìm thấy document nào với idUser: $id');
        throw Exception('Không tìm thấy document');
      }
    } catch (e) {
      print('Lỗi khi cập nhật StepOfDays: $e');
      throw Exception('Lỗi khi cập nhật StepOfDays: $e');
    }
  }
}
