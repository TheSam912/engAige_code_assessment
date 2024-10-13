import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_tracker/models/meal.dart';

class DatabaseHelper {
  late Box<MealModel> _hive;
  late List<MealModel> _box;

  DatabaseHelper();

  ///Get all meals from database
  List<MealModel> getMeals() {
    _hive = Hive.box<MealModel>('mealsDB');
    _box = _hive.values.toList();
    return _box;
  }

  /// Add Meal to Database
  List<MealModel> addMeal(MealModel meal) {
    _hive.add(meal);
    return _hive.values.toList();
  }

  /// Remove Particular meal by id
  List<MealModel> removeMeal(String id) {
    _hive.deleteAt(_hive.values.toList().indexWhere((element) => element.id == id));
    return _hive.values.toList();
  }

  /// Update Meal
  List<MealModel> updateMeal(int index, MealModel meal) {
    _hive.putAt(index, meal);
    return _hive.values.toList();
  }

  /// Delete All Meals in Database
  void deleteAll() {
    _box.clear();
  }
}
