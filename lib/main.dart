import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meal_tracker/models/meal.dart';
import 'package:meal_tracker/models/meal_item.dart';
import 'package:meal_tracker/screens/input_meal_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealModelAdapter());
  Hive.registerAdapter(MealItemAdapter());
  await Hive.openBox<MealModel>('mealsDB');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Meal Tracker App',
      debugShowCheckedModeBanner: false,
      home: InputMealData(),
    );
  }
}
