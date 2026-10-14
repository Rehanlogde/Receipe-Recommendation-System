import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_app/models/video.dart';
import 'package:recipe_app/providers/service_providers.dart';

final recipeVideoProvider = FutureProvider.family<Video?, String>((
  ref,
  recipeId,
) {
  return ref.watch(videoServiceProvider).getVideoForRecipe(recipeId);
});
