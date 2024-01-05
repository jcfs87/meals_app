import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/widgets/switch_widget.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchWidget(
            filterType: activeFilters[Filter.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            onFilterChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, value);
            },
          ),
          SwitchWidget(
            filterType: activeFilters[Filter.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            onFilterChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, value);
            },
          ),
          SwitchWidget(
            filterType: activeFilters[Filter.vegetarian]!,
            title: 'Vegetarian',
            subtitle: 'Only includes vegetarian meals.',
            onFilterChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, value);
            },
          ),
          SwitchWidget(
            filterType: activeFilters[Filter.vegan]!,
            title: 'Vegan',
            subtitle: 'Only includes vegan meals.',
            onFilterChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, value);
            },
          ),
        ],
      ),
    );
  }
}