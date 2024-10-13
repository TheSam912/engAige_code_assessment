import 'package:hive/hive.dart';
import 'package:meal_tracker/models/meal_item.dart';
import 'package:uuid/uuid.dart';

part 'meal.g.dart';

@HiveType(typeId: 1)
class MealModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final MealItem breakfast;
  @HiveField(2)
  final MealItem lunch;
  @HiveField(3)
  final MealItem dinner;
  @HiveField(4)
  final MealItem snack;

  MealModel({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
  }) : id = const Uuid().v4();

  MealModel copyWith({
    String? id,
    MealItem? breakfast,
    MealItem? lunch,
    MealItem? dinner,
    MealItem? snack,
  }) {
    return MealModel(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
      snack: snack ?? this.snack,
    );
  }
}
