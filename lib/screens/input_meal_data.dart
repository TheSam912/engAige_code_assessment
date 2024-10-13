import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meal_tracker/constant/constant.dart';
import 'package:meal_tracker/models/meal.dart';
import 'package:meal_tracker/models/meal_item.dart';
import 'package:meal_tracker/screens/widgets/alert_dialog.dart';
import 'package:meal_tracker/screens/widgets/app_bar.dart';
import 'package:meal_tracker/screens/widgets/custom_buttons.dart';
import 'package:meal_tracker/screens/widgets/icons.dart';
import 'package:meal_tracker/screens/widgets/line.dart';
import 'package:meal_tracker/screens/widgets/meal_bottomsheet.dart';
import 'package:meal_tracker/screens/widgets/snack_bar.dart';
import '../constant/colors.dart';
import '../provider/meal_provider.dart';
import '../provider/meal_selection_provider.dart';
import '../utils/translate_helper.dart';

class InputMealData extends StatefulHookConsumerWidget {
  const InputMealData({super.key});

  @override
  ConsumerState<InputMealData> createState() => _InputMealDataState();
}

class _InputMealDataState extends ConsumerState<InputMealData> {
  List<MealModel>? allMeals;
  bool completed = true;
  String id = "";

  @override
  void initState() {
    super.initState();
    _initializeMeals();
  }

  Future<void> _initializeMeals() async {
    allMeals = await ref.read(getAllMealsProvider);
    if (allMeals != null && allMeals!.isNotEmpty) {
      id = allMeals![0].id;
      ref.read(mealSelectionProvider.notifier).initializeMealSelection(allMeals![0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealSelections = ref.watch(mealSelectionProvider);

    if (mealSelections.length == 4 && completed) {
      setState(() {
        completed = false;
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: myAppBar("Ernährung", () {
          showAlertDialog(context, "engAIge GmbH",
              "Meal track flutter app developed by Sam Nolan as a code assessment ");
        }),
      ),
      body: Column(
        children: [
          line(completed),
          Expanded(
            child: ListView.builder(
              itemCount: mealType.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final selectedType = mealType[index];
                final mealSelection = mealSelections[selectedType];

                return _buildMealSelectionTile(context, selectedType, mealSelection);
              },
            ),
          ),
          buttonDesign(() => _saveData(mealSelections, completed), "Speichern", false),
          buttonDesign(() {}, "Abbrechen", true),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _buildMealSelectionTile(
      BuildContext context, String selectedType, MealItem? mealSelection) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translateMeal(selectedType),
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              if (mealSelection != null) _buildMealDetails(mealSelection),
            ],
          ),
          mealSelection == null
              ? IconButton(
                  onPressed: () => _showMealBottomSheet(context, selectedType),
                  icon: Icon(Icons.add_box, color: primaryRed),
                )
              : Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_box, color: primaryRed),
                    ),
                    IconButton(
                      onPressed: () => _showMealBottomSheet(context, selectedType),
                      icon: Icon(Icons.edit, color: primaryRed),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildMealDetails(MealItem mealSelection) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text("Fett:", style: _mealInfoTextStyle),
          _buildInfoBadge(mealSelection.fat),
          const SizedBox(width: 8),
          const Text("Zucker:", style: _mealInfoTextStyle),
          _buildInfoBadge(mealSelection.sugar),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryRed,
      ),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }

  void _showMealBottomSheet(BuildContext context, String mealType) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MealBottomSheet(mealType: mealType),
    );
  }

  _saveData(mealSelections, bool isNew) {
    final mealSelection = ref.read(mealSelectionProvider);
    if (mealSelections.length == 4) {
      final breakfastSelection = mealSelection['breakfast']!;
      final lunchSelection = mealSelection['lunch']!;
      final dinnerSelection = mealSelection['dinner']!;
      final snackSelection = mealSelection['snack']!;

      final newMeal = MealModel(
        breakfast: MealItem(sugar: breakfastSelection.sugar, fat: breakfastSelection.fat),
        lunch: MealItem(sugar: lunchSelection.sugar, fat: lunchSelection.fat),
        dinner: MealItem(sugar: dinnerSelection.sugar, fat: dinnerSelection.fat),
        snack: MealItem(sugar: snackSelection.sugar, fat: snackSelection.fat),
      );

      if (allMeals!.isEmpty) {
        ref.read(hiveData.notifier).addMeal(newMeal);
        allMeals = ref.read(getAllMealsProvider);
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar("Essensdaten erfolgreich gespeichert !"));
      } else {
        ref.read(hiveData.notifier).updateMeal(0, newMeal);
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar("Lebensmitteldaten erfolgreich aktualisiert!"));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar("bitte wählen Sie Daten für alle !"));
    }
  }

  static const TextStyle _mealInfoTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
}
