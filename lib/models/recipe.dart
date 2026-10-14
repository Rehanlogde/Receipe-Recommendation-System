import 'package:recipe_app/models/cooking_step.dart';
import 'package:recipe_app/models/recipe_ingredient.dart';

class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
    this.videoId,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty;
  final List<RecipeIngredient> ingredients;
  final List<CookingStep> steps;
  final String? videoId;
  final String? imageUrl;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map(
            (item) => RecipeIngredient.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      steps: (json['steps'] as List<dynamic>)
          .map((item) => CookingStep.fromJson(item as Map<String, dynamic>))
          .toList(),
      videoId: json['videoId'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'difficulty': difficulty,
      'ingredients': ingredients.map((item) => item.toJson()).toList(),
      'steps': steps.map((item) => item.toJson()).toList(),
      'videoId': videoId,
      'imageUrl': imageUrl,
    };
  }

  RecipeMatchInfo getMatchInfo(Set<String> selectedIds) {
    final matched = <RecipeIngredient>[];
    final missing = <RecipeIngredient>[];

    for (final item in ingredients) {
      final isSelected =
          selectedIds.contains(item.ingredientId) ||
          selectedIds.any((id) {
            final cleanId = id.toLowerCase().replaceAll(
              RegExp(r'^(ing-|custom-)'),
              '',
            );
            final cleanItemId = item.ingredientId.toLowerCase().replaceAll(
              'ing-',
              '',
            );
            final cleanName = item.name.toLowerCase();
            return cleanId == cleanItemId ||
                cleanId == cleanName ||
                cleanName.contains(cleanId);
          });

      if (isSelected) {
        matched.add(item);
      } else {
        missing.add(item);
      }
    }

    return RecipeMatchInfo(
      matchedCount: matched.length,
      totalCount: ingredients.length,
      matchedIngredients: matched,
      missingIngredients: missing,
    );
  }
}

class RecipeMatchInfo {
  const RecipeMatchInfo({
    required this.matchedCount,
    required this.totalCount,
    required this.matchedIngredients,
    required this.missingIngredients,
  });

  final int matchedCount;
  final int totalCount;
  final List<RecipeIngredient> matchedIngredients;
  final List<RecipeIngredient> missingIngredients;

  bool get isComplete => matchedCount == totalCount && totalCount > 0;
  bool get hasMatch => matchedCount > 0;
  bool get hasMissing => missingIngredients.isNotEmpty;
}
