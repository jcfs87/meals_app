import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    //required this.onToggleFavorite,
  });
  
  /* title is optional para que pueda ser null y
   ver video 165 minuto 11*/
  final String? title;
  final List<Meal> meals;

 // final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailsScreen(
          meal: meal,
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MealsDetailsScreen(meal: meal),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // variable of type widget wich defined content or body
    Widget contenido = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      contenido = ListView.builder(
        /* this line itemCount: meals.length is important to make sure
      that flutter renders the list view correctly */
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: selectMeal
        ),
      );
    }
    if (title == null) {
      return contenido;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: contenido,
    );
  }
}
