import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meal_tracker/controller/meal_controller.dart';
import 'package:meal_tracker/database/database_helper.dart';
import 'package:meal_tracker/models/meal.dart';

final providerHive = Provider<DatabaseHelper>((ref) => DatabaseHelper());

final hiveData =
    StateNotifierProvider<MealController, List<MealModel>?>((ref) => MealController(ref));

final getAllMealsProvider = Provider<List<MealModel>>((ref) {
  final hiveDatas = ref.watch(hiveData);
  return hiveDatas ?? [];
});
