import 'package:hive/hive.dart';

part 'meal_item.g.dart';

@HiveType(typeId: 2)
class MealItem extends HiveObject {
  @HiveField(0)
  final String sugar;

  @HiveField(1)
  final String fat;

  MealItem({
    required this.sugar,
    required this.fat,
  });

  MealItem copyWith({String? sugar, String? fat}) {
    return MealItem(
      sugar: sugar ?? this.sugar,
      fat: fat ?? this.fat,
    );
  }

  @override
  String toString() => 'Meal(sugar: $sugar, fat: $fat)';
}
