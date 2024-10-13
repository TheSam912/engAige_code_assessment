import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/meal.dart';
import '../models/meal_item.dart';

class MealSelectionNotifier extends StateNotifier<Map<String, MealItem>> {
  MealSelectionNotifier() : super({});

  void setSugarSize(String mealType, String sugarSize) {
    state = {
      ...state,
      mealType: MealItem(
        sugar: sugarSize,
        fat: state[mealType]?.fat ?? "mittle",
      ),
    };
  }

  void setFatSize(String mealType, String fatSize) {
    state = {
      ...state,
      mealType: MealItem(
        sugar: state[mealType]?.sugar ?? "mittle",
        fat: fatSize,
      ),
    };
  }

  void initializeMealSelection(MealModel meal) {
    state = {
      'breakfast': MealItem(sugar: meal.breakfast.sugar, fat: meal.breakfast.fat),
      'lunch': MealItem(sugar: meal.lunch.sugar, fat: meal.lunch.fat),
      'dinner': MealItem(sugar: meal.dinner.sugar, fat: meal.dinner.fat),
      'snack': MealItem(sugar: meal.snack.sugar, fat: meal.snack.fat),
    };
  }

  void removeMeal(String mealType) {
    final updatedState = Map<String, MealItem>.from(state);
    updatedState.remove(mealType);
    state = updatedState;
  }

  void clearAllMeals() {
    state = {};
  }
}

final mealSelectionProvider = StateNotifierProvider<MealSelectionNotifier, Map<String, MealItem>>(
  (ref) => MealSelectionNotifier(),
);
