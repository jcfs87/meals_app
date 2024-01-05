import 'package:flutter/material.dart';

/* statefulwidget because i need manage some internal user input state */
class SwitchWidget extends StatefulWidget {
   const SwitchWidget({
    super.key,
    required this.filterType,
    required this.title,
    required this.subtitle,
    required this.onFilterChanged,
  });

  final bool filterType;
  final String title;
  final String subtitle;
  final Function(bool) onFilterChanged;

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.filterType,
      onChanged: (isChecked) {
        widget.onFilterChanged(isChecked);
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
