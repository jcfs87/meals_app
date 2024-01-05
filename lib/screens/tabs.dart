import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_providers.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

/* Tab base navigation video 165 and then en the video 183 i implement provider
so i change StatefulWidget for ConsumerStatefulWidget */
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

/* In the video 183 we change State for ConsumerState */
class _TabsScreenState extends ConsumerState<TabsScreen> {
  //the value is zero for the first page and one for the second
  int _selectedPageIndex = 0;
  // using favorites provider we don't need the line 35 see video 185
  //final List<Meal> _favoriteMeals = [];
  //video 175 para filtrar los meals video 188 usamos provider y no lo necesitamos mas
  //Map<Filter, bool> _selectedFilters = kInitialFilters;

  //this method is no necesary here we change in the video 186
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

/* this function shoulb be add or remove a meal from the 
favoriteMeals and in the video 185 we delete this function because
we managing this in our StateNotifier 51 to 65 */
  // void _toggleMealFavoritesStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite!');
  //     });
  //   }
  // }

  //this metohod allow change between tabs or pages
  void _selectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  /* Esta funcion pasara el valor a main drawer video 169 y 171 */
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
      /* ?? operator si result es null toma el valor de kInitialFilters */
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // }); i don't need this any more because now I'm using the provider video 188
    }
  }

  @override
  Widget build(BuildContext context) {
    //video 175 filtramos los meals
    /* now we can use ref property that allows us to set up listeners to our provider 
    video 183 watch is the most recommend and we change dummyMeals.where and then we change the logic
    to filter provider and put in the file filters provider in the video 190*/
    
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
     //no es necesario porque usamos provider onToggleFavorite: _toggleMealFavoritesStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      /* here we change  meals: _favoriteMeals for meals: favoriteMeals video 185 */
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        //this text depend of wich tap is selected
        title: Text(activePageTitle),
      ),
      // side drawer to filter screen video 168
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectePage,
        // set this to our selected page index this control
        // wich tab will be highlighted
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
