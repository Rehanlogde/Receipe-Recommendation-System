import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/providers/service_providers.dart';

final ingredientsProvider = FutureProvider<List<Ingredient>>((ref) {
  return ref.watch(ingredientServiceProvider).getIngredients();
});

class CustomIngredientsNotifier extends StateNotifier<List<Ingredient>> {
  CustomIngredientsNotifier() : super(const []);

  Ingredient addCustom(String name) {
    final trimmed = name.trim();
    final slug = trimmed.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
    final id = 'custom-$slug';

    final existing = state.where((item) => item.id == id).firstOrNull;
    if (existing != null) return existing;

    final ingredient = Ingredient(id: id, name: trimmed, category: 'Custom');
    state = [...state, ingredient];
    return ingredient;
  }
}

final customIngredientsProvider =
    StateNotifierProvider<CustomIngredientsNotifier, List<Ingredient>>((ref) {
      return CustomIngredientsNotifier();
    });

final allIngredientsProvider = FutureProvider<List<Ingredient>>((ref) async {
  final predefined = await ref.watch(ingredientsProvider.future);
  final custom = ref.watch(customIngredientsProvider);
  return [...predefined, ...custom];
});

class SelectedIngredientsNotifier extends StateNotifier<Set<String>> {
  SelectedIngredientsNotifier() : super(<String>{});

  void toggle(String ingredientId) {
    if (state.contains(ingredientId)) {
      state = {...state}..remove(ingredientId);
    } else {
      state = {...state, ingredientId};
    }
  }

  void add(String ingredientId) {
    if (!state.contains(ingredientId)) {
      state = {...state, ingredientId};
    }
  }

  void remove(String ingredientId) {
    if (state.contains(ingredientId)) {
      state = {...state}..remove(ingredientId);
    }
  }

  void clear() => state = <String>{};
}

final selectedIngredientsProvider =
    StateNotifierProvider<SelectedIngredientsNotifier, Set<String>>((ref) {
      return SelectedIngredientsNotifier();
    });

final selectedIngredientObjectsProvider = Provider<List<Ingredient>>((ref) {
  final selectedIds = ref.watch(selectedIngredientsProvider);
  final all = ref.watch(allIngredientsProvider).asData?.value ?? [];
  return all.where((item) => selectedIds.contains(item.id)).toList();
});
