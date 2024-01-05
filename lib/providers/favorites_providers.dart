import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

/* if we have data and change under certain circumstances StateNotifier*/
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
   FavoriteMealsNotifier() : super([]);

/* When you use StateNotifier is not allow to edit an existing value in memory. 
that's simply a pattern enforced by this package is not allow add or remove.
the property state hold your data "list meal" */
   bool toggleMealFavoritesStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    
    //here in the line 16 we remove a meal to favorite list 
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    //here in the line 20 we add a meal to the favorite list  
    } else {
      state = [...state, meal];
      return true;
    }
   }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});