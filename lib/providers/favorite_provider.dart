import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<Set<String>> {
  FavoriteNotifier() : super(<String>{});

  void toggle(String recipeId) {
    if (state.contains(recipeId)) {
      state = {...state}..remove(recipeId);
    } else {
      state = {...state, recipeId};
    }
  }

  bool contains(String recipeId) => state.contains(recipeId);
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Set<String>>((
  ref,
) {
  return FavoriteNotifier();
});
