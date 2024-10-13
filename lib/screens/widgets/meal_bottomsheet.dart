import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_tracker/utils/translate_helper.dart';
import '../../constant/colors.dart';
import '../../provider/meal_selection_provider.dart';
import 'alert_dialog.dart';

class MealBottomSheet extends ConsumerWidget {
  String mealType;

  MealBottomSheet({super.key, required this.mealType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mealSelection = ref.watch(mealSelectionProvider)[mealType];
    String translatedMealType = translateMeal(mealType);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fettgehalt $translatedMealType'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Niedrig', 'mittel', 'hoch'].map((value) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(mealSelectionProvider.notifier).setFatSize(mealType, value);
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: primaryRed, width: 1.5),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  backgroundColor: mealSelection?.fat == value ? primaryRed : Colors.white,
                  foregroundColor: mealSelection?.fat == value ? Colors.white : primaryRed,
                ),
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text('Zuckergehalt $translatedMealType'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Niedrig', 'mittel', 'hoch'].map((value) {
              final mealSelection = ref.watch(mealSelectionProvider)[mealType];
              return ElevatedButton(
                onPressed: () {
                  ref.read(mealSelectionProvider.notifier).setSugarSize(mealType, value);
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: primaryRed, width: 1.5),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  backgroundColor: mealSelection?.sugar == value ? primaryRed : Colors.white,
                  foregroundColor: mealSelection?.sugar == value ? Colors.white : primaryRed,
                ),
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: primaryRed)),
                    child: Icon(
                      Icons.close,
                      color: primaryRed,
                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  if (mealSelection == null) {
                    showAlertDialog(context, "WeMakeItSafer", "Bite wählen Sie Fett und Zucker !");
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: primaryRed),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
