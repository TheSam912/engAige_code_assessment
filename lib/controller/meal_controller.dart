import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meal_tracker/database/database_helper.dart';
import 'package:meal_tracker/models/meal.dart';

import '../provider/meal_provider.dart';

class MealController extends StateNotifier<List<MealModel>?> {
  MealController(this.ref) : super(null) {
    repo = ref.read(providerHive);
    fetchMeals();
  }

  late DatabaseHelper? repo;
  final StateNotifierProviderRef ref;

  ///fetch all meals from to local Storage

  void fetchMeals() {
    state = repo!.getMeals();
  }

  ///add meal to local Storage

  void addMeal(MealModel meal) {
    state = repo!.addMeal(meal);
  }

  ///remove meal from local Storage
  void removeMeal(String id) {
    state = repo!.removeMeal(id);
  }

  ///Update  current meal from local Storage

  void updateMeal(int index, MealModel meal) {
    state = repo!.updateMeal(index, meal);
  }
}
