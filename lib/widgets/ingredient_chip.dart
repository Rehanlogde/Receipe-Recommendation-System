import 'package:flutter/material.dart';

import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/models/ingredient.dart';

class IngredientChip extends StatelessWidget {
  const IngredientChip({
    super.key,
    required this.ingredient,
    required this.selected,
    required this.onTap,
  });

  final Ingredient ingredient;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(ingredient.name),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: true,
      selectedColor: AppColors.primarySoft,
      side: BorderSide(color: selected ? AppColors.primary : AppColors.outline),
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
