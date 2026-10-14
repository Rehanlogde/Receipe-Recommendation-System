import 'package:recipe_app/models/video.dart';

abstract class VideoService {
  Future<Video?> getVideoForRecipe(String recipeId);
}
