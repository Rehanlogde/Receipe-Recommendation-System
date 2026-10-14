import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/models/video.dart';
import 'package:recipe_app/services/mock/mock_data.dart';
import 'package:recipe_app/services/video_service.dart';

class MockVideoService implements VideoService {
  @override
  Future<Video?> getVideoForRecipe(String recipeId) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    try {
      return MockData.videos.firstWhere((video) => video.recipeId == recipeId);
    } on StateError {
      return null;
    }
  }
}
