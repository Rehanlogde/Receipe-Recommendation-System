import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/app/router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/app_spacing.dart';
import 'package:recipe_app/core/localization/l10n_x.dart';
import 'package:recipe_app/core/utils/max_width.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/providers/ingredient_provider.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/empty_state.dart';
import 'package:recipe_app/widgets/error_state.dart';
import 'package:recipe_app/widgets/ingredient_chip.dart';
import 'package:recipe_app/widgets/loading_widget.dart';

class IngredientSelectionScreen extends ConsumerStatefulWidget {
  const IngredientSelectionScreen({super.key});

  @override
  ConsumerState<IngredientSelectionScreen> createState() =>
      _IngredientSelectionScreenState();
}

class _IngredientSelectionScreenState
    extends ConsumerState<IngredientSelectionScreen> {
  final _searchController = TextEditingController();
  final _customInputController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _customInputController.dispose();
    super.dispose();
  }

  void _addCustom(String rawName) {
    final name = rawName.trim();
    if (name.isEmpty) return;

    final ingredient = ref
        .read(customIngredientsProvider.notifier)
        .addCustom(name);
    ref.read(selectedIngredientsProvider.notifier).add(ingredient.id);
    _customInputController.clear();
    _searchController.clear();
    setState(() => _query = '');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "$name" to your kitchen'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddCustomDialog() {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.addCustomIngredient),
        content: TextField(
          controller: _customInputController,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.enterIngredientName),
          onSubmitted: (value) {
            Navigator.pop(ctx);
            _addCustom(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _addCustom(_customInputController.text);
            },
            child: Text(l10n.add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final allIngredientsAsync = ref.watch(allIngredientsProvider);
    final selectedIds = ref.watch(selectedIngredientsProvider);
    final selectedItems = ref.watch(selectedIngredientObjectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectIngredients),
        actions: [
          IconButton(
            tooltip: l10n.addCustomIngredient,
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: _showAddCustomDialog,
          ),
        ],
      ),
      body: allIngredientsAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(allIngredientsProvider),
        ),
        data: (allIngredients) {
          final filtered = _filter(allIngredients);
          final grouped = _group(filtered);

          return Column(
            children: [
              // Search Field
              MaxWidth(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: l10n.searchIngredients,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),

              // Selected Ingredients Tray
              if (selectedIds.isNotEmpty) ...[
                MaxWidth(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.selectedIngredientsTitle(selectedIds.length),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                            ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => ref
                                  .read(selectedIngredientsProvider.notifier)
                                  .clear(),
                              icon: const Icon(
                                Icons.delete_sweep_rounded,
                                size: 16,
                              ),
                              label: Text(l10n.clearAll),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 38,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final item = selectedItems[index];
                              return InputChip(
                                label: Text(item.name),
                                deleteIcon: const Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                ),
                                onDeleted: () => ref
                                    .read(selectedIngredientsProvider.notifier)
                                    .remove(item.id),
                                backgroundColor: AppColors.primarySoft,
                                side: BorderSide.none,
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Categorized Ingredients List or Empty State
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              EmptyState(
                                title: l10n.noIngredients,
                                message: l10n.selectIngredientsHint,
                                icon: Icons.search_off_rounded,
                              ),
                              if (_query.trim().isNotEmpty) ...[
                                const SizedBox(height: 12),
                                FilledButton.tonalIcon(
                                  icon: const Icon(Icons.add_rounded),
                                  label: Text(
                                    'Add "${_query.trim()}" to kitchen',
                                  ),
                                  onPressed: () => _addCustom(_query),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : MaxWidth(
                        child: ListView(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          children: [
                            for (final entry in grouped.entries) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 8,
                                ),
                                child: Text(
                                  entry.key,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final ingredient in entry.value)
                                    IngredientChip(
                                      ingredient: ingredient,
                                      selected: selectedIds.contains(
                                        ingredient.id,
                                      ),
                                      onTap: () => ref
                                          .read(
                                            selectedIngredientsProvider
                                                .notifier,
                                          )
                                          .toggle(ingredient.id),
                                    ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 24),
                            // Quick manual add link at the bottom of the list
                            Center(
                              child: TextButton.icon(
                                icon: const Icon(Icons.add_rounded),
                                label: Text(l10n.addCustomIngredient),
                                onPressed: _showAddCustomDialog,
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: MaxWidth(
            child: AppButton(
              label: selectedIds.isEmpty
                  ? l10n.getRecommendations
                  : '${l10n.getRecommendations} (${selectedIds.length})',
              icon: Icons.restaurant_menu_rounded,
              onPressed: () {
                if (selectedIds.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.selectAtLeastOne)),
                  );
                  return;
                }
                context.push(AppRoutes.recipes);
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Ingredient> _filter(List<Ingredient> ingredients) {
    final needle = _query.trim().toLowerCase();
    if (needle.isEmpty) return ingredients;
    return ingredients
        .where(
          (item) =>
              item.name.toLowerCase().contains(needle) ||
              item.category.toLowerCase().contains(needle),
        )
        .toList();
  }

  Map<String, List<Ingredient>> _group(List<Ingredient> ingredients) {
    final map = <String, List<Ingredient>>{};
    for (final ingredient in ingredients) {
      map.putIfAbsent(ingredient.category, () => []).add(ingredient);
    }
    return map;
  }
}
