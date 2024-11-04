import 'package:fitnessapp/presentation/widgets/my_medicine/session_header.dart';
import 'package:flutter/material.dart';
import '../../../data/models/medicine_model.dart';
import '../../widgets/my_medicine/medicine_card.dart';

class MedicineSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final List<MedicineModel> medicines;
  final VoidCallback onToggle;
  final Function(MedicineModel) onEditPressed;

  const MedicineSection({
    required this.title,
    required this.isExpanded,
    required this.medicines,
    required this.onToggle,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          isExpanded: isExpanded,
          onToggle: onToggle,
        ),
        if (isExpanded)
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              MedicineModel medicine = medicines[index];
              return MedicineCard(
                medicineName: medicine.medicineName,
                dosageTime: medicine.dosageTime,
                remainingDoses: medicine.remainingDoses,
                offStatus: medicine.offStatus,
                usageStatus: medicine.usageStatus,
                iconRight: "edit",
                onEditPressed: () => onEditPressed(medicine),
              );
            },
          ),
      ],
    );
  }
}
