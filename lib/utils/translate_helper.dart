import '../constant/constant.dart';

String translateMeal(String meal) {
  return mealTranslations[meal] ?? meal;
}
