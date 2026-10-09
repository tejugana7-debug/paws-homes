import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<String> categories = ['All', 'Dogs', 'Cats', 'Birds'];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selected,
              onSelected: (_) => onCategorySelected(category),
              selectedColor: colors.primary,
              backgroundColor: colors.surface,
              labelStyle: TextStyle(
                color: selected ? colors.onPrimary : colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide(
                color: selected ? colors.primary : colors.outlineVariant,
              ),
            ),
          );
        },
      ),
    );
  }
}
