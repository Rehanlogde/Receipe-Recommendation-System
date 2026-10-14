import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/favorite_provider.dart';
import 'package:recipe_app/providers/ingredient_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/empty_state.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/loading_widget.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class RecipeListScreen extends ConsumerStatefulWidget {
  const RecipeListScreen({super.key});

  @override
  ConsumerState<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends ConsumerState<RecipeListScreen> {
  String _selectedCategory = 'All';
  String _selectedDifficulty = 'All';
  int _maxCookTime = 0; // 0 means any
  String _sortBy = 'match'; // 'match', 'quickest', 'missing'
  String _searchQuery = '';
  final _searchController = TextEditingController();

  static const _categories = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Soup'];
  static const _difficulties = ['All', 'Easy', 'Medium', 'Hard'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedIngredients = ref.watch(selectedIngredientsProvider);
    final favorites = ref.watch(favoriteProvider);

    // If no ingredients selected, show all/popular recipes as fallback
    final recipesAsync = selectedIngredients.isEmpty
        ? ref.watch(popularRecipesProvider)
        : ref.watch(recommendedRecipesProvider);

    final title = selectedIngredients.isEmpty
        ? l10n.allRecipesTitle
        : l10n.recommendedRecipes;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: l10n.selectIngredients,
            icon: const Icon(Icons.kitchen_rounded),
            onPressed: () => context.push(AppRoutes.ingredients),
          ),
        ],
      ),
      body: recipesAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () {
            if (selectedIngredients.isEmpty) {
              ref.invalidate(popularRecipesProvider);
            } else {
              ref.invalidate(recommendedRecipesProvider);
            }
          },
        ),
        data: (recipes) {
          final filtered = _filterAndSortRecipes(recipes, selectedIngredients);

          return Column(
            children: [
              // Search Field
              MaxWidth(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: l10n.searchHintHome,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),

              // Category Filter Chips
              MaxWidth(
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(
                          category == 'All' ? l10n.filterAll : category,
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primarySoft,
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.outline,
                        ),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 13,
                        ),
                        onSelected: (_) =>
                            setState(() => _selectedCategory = category),
                      );
                    },
                  ),
                ),
              ),

              // Secondary Filters & Sorting Controls Strip
              MaxWidth(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Sort Dropdown Menu
                        PopupMenuButton<String>(
                          tooltip: l10n.sortBy,
                          initialValue: _sortBy,
                          onSelected: (val) => setState(() => _sortBy = val),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _sortBy != 'match'
                                    ? AppColors.primary
                                    : AppColors.outline,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.sort_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _sortByLabel(l10n),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'match',
                              child: Text(l10n.sortBestMatch),
                            ),
                            PopupMenuItem(
                              value: 'quickest',
                              child: Text(l10n.sortQuickest),
                            ),
                            PopupMenuItem(
                              value: 'missing',
                              child: Text(l10n.sortFewestMissing),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),

                        // Difficulty Filter Menu
                        PopupMenuButton<String>(
                          tooltip: l10n.filterDifficulty,
                          initialValue: _selectedDifficulty,
                          onSelected: (val) =>
                              setState(() => _selectedDifficulty = val),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _selectedDifficulty != 'All'
                                    ? AppColors.primary
                                    : AppColors.outline,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.bar_chart_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _selectedDifficulty == 'All'
                                      ? l10n.filterDifficulty
                                      : _selectedDifficulty,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => [
                            for (final d in _difficulties)
                              PopupMenuItem(
                                value: d,
                                child: Text(d == 'All' ? l10n.filterAll : d),
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),

                        // Max Cook Time Filter Menu
                        PopupMenuButton<int>(
                          tooltip: l10n.filterMaxTime,
                          initialValue: _maxCookTime,
                          onSelected: (val) =>
                              setState(() => _maxCookTime = val),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _maxCookTime > 0
                                    ? AppColors.primary
                                    : AppColors.outline,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _maxCookTime == 0
                                      ? l10n.filterMaxTime
                                      : '≤ $_maxCookTime min',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 0, child: Text(l10n.anyTime)),
                            PopupMenuItem(
                              value: 30,
                              child: Text(l10n.under30Min),
                            ),
                            PopupMenuItem(
                              value: 45,
                              child: Text(l10n.under45Min),
                            ),
                          ],
                        ),

                        // Reset filters if active
                        if (_selectedDifficulty != 'All' ||
                            _maxCookTime > 0 ||
                            _sortBy != 'match' ||
                            _selectedCategory != 'All' ||
                            _searchQuery.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          TextButton(
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedCategory = 'All';
                                _selectedDifficulty = 'All';
                                _maxCookTime = 0;
                                _sortBy = 'match';
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                            child: const Text(
                              'Reset',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // Summary Bar: kitchen ingredients active
              if (selectedIngredients.isNotEmpty) ...[
                MaxWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.selectedCount(selectedIngredients.length),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        InkWell(
                          onTap: () => context.push(AppRoutes.ingredients),
                          child: Text(
                            'Edit kitchen items',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Results List or Empty State
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: EmptyState(
                            title: l10n.noRecipes,
                            message: l10n.noRecipesHint,
                            icon: Icons.menu_book_outlined,
                            action: AppButton(
                              label: l10n.selectIngredients,
                              icon: Icons.kitchen_rounded,
                              onPressed: () =>
                                  context.push(AppRoutes.ingredients),
                            ),
                          ),
                        ),
                      )
                    : MaxWidth(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: filtered.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final recipe = filtered[index];
                            final matchInfo = recipe.getMatchInfo(
                              selectedIngredients,
                            );
                            final isFav = favorites.contains(recipe.id);

                            return RecipeCard(
                              recipe: recipe,
                              matchInfo: selectedIngredients.isNotEmpty
                                  ? matchInfo
                                  : null,
                              isFavorite: isFav,
                              onFavoriteToggle: () => ref
                                  .read(favoriteProvider.notifier)
                                  .toggle(recipe.id),
                              onTap: () => context.push(
                                '${AppRoutes.recipes}/${recipe.id}',
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _sortByLabel(dynamic l10n) {
    switch (_sortBy) {
      case 'quickest':
        return l10n.sortQuickest;
      case 'missing':
        return l10n.sortFewestMissing;
      case 'match':
      default:
        return l10n.sortBestMatch;
    }
  }

  List<Recipe> _filterAndSortRecipes(
    List<Recipe> recipes,
    Set<String> selectedIngredients,
  ) {
    var result = List<Recipe>.from(recipes);

    // Filter by Category
    if (_selectedCategory != 'All') {
      result = result
          .where(
            (r) => r.category.toLowerCase() == _selectedCategory.toLowerCase(),
          )
          .toList();
    }

    // Filter by Difficulty
    if (_selectedDifficulty != 'All') {
      result = result
          .where(
            (r) =>
                r.difficulty.toLowerCase() == _selectedDifficulty.toLowerCase(),
          )
          .toList();
    }

    // Filter by Max Cook Time
    if (_maxCookTime > 0) {
      result = result.where((r) => r.cookTimeMinutes <= _maxCookTime).toList();
    }

    // Filter by Search Query
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      result = result.where((r) {
        return r.title.toLowerCase().contains(q) ||
            r.description.toLowerCase().contains(q);
      }).toList();
    }

    // Sort Results
    if (_sortBy == 'quickest') {
      result.sort((a, b) => a.cookTimeMinutes.compareTo(b.cookTimeMinutes));
    } else if (_sortBy == 'missing') {
      result.sort((a, b) {
        final missingA = a
            .getMatchInfo(selectedIngredients)
            .missingIngredients
            .length;
        final missingB = b
            .getMatchInfo(selectedIngredients)
            .missingIngredients
            .length;
        return missingA.compareTo(missingB);
      });
    } else {
      // Best Match
      if (selectedIngredients.isNotEmpty) {
        result.sort((a, b) {
          final matchA = a.getMatchInfo(selectedIngredients).matchedCount;
          final matchB = b.getMatchInfo(selectedIngredients).matchedCount;
          if (matchB != matchA) {
            return matchB.compareTo(matchA);
          }
          final missingA = a
              .getMatchInfo(selectedIngredients)
              .missingIngredients
              .length;
          final missingB = b
              .getMatchInfo(selectedIngredients)
              .missingIngredients
              .length;
          return missingA.compareTo(missingB);
        });
      }
    }

    return result;
  }
}
