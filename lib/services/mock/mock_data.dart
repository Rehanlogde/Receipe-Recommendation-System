import 'package:recipe_app/models/cooking_step.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/models/recipe_ingredient.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/models/video.dart';

/// Sample data used only by mock services. UI screens must not import this file.
abstract final class MockData {
  static const User demoUser = User(
    id: 'user-1',
    name: 'Amaira',
    email: 'amaira@example.com',
  );

  static const List<Ingredient> ingredients = [
    Ingredient(id: 'ing-onion', name: 'Onion', category: 'Vegetable'),
    Ingredient(id: 'ing-tomato', name: 'Tomato', category: 'Vegetable'),
    Ingredient(id: 'ing-potato', name: 'Potato', category: 'Vegetable'),
    Ingredient(id: 'ing-garlic', name: 'Garlic', category: 'Vegetable'),
    Ingredient(id: 'ing-ginger', name: 'Ginger', category: 'Vegetable'),
    Ingredient(
      id: 'ing-green-chilli',
      name: 'Green chilli',
      category: 'Vegetable',
    ),
    Ingredient(id: 'ing-spinach', name: 'Spinach', category: 'Vegetable'),
    Ingredient(id: 'ing-capsicum', name: 'Capsicum', category: 'Vegetable'),
    Ingredient(id: 'ing-rice', name: 'Rice', category: 'Grain'),
    Ingredient(id: 'ing-atta', name: 'Wheat flour', category: 'Grain'),
    Ingredient(id: 'ing-toor-dal', name: 'Toor dal', category: 'Lentil'),
    Ingredient(id: 'ing-moong-dal', name: 'Moong dal', category: 'Lentil'),
    Ingredient(id: 'ing-paneer', name: 'Paneer', category: 'Dairy'),
    Ingredient(id: 'ing-curd', name: 'Curd', category: 'Dairy'),
    Ingredient(id: 'ing-ghee', name: 'Ghee', category: 'Dairy'),
    Ingredient(id: 'ing-milk', name: 'Milk', category: 'Dairy'),
    Ingredient(id: 'ing-cumin', name: 'Cumin', category: 'Spice'),
    Ingredient(id: 'ing-turmeric', name: 'Turmeric', category: 'Spice'),
    Ingredient(
      id: 'ing-chilli-powder',
      name: 'Red chilli powder',
      category: 'Spice',
    ),
    Ingredient(id: 'ing-garam-masala', name: 'Garam masala', category: 'Spice'),
    Ingredient(id: 'ing-mustard', name: 'Mustard seeds', category: 'Spice'),
    Ingredient(id: 'ing-oil', name: 'Cooking oil', category: 'Staple'),
    Ingredient(id: 'ing-salt', name: 'Salt', category: 'Staple'),
    Ingredient(id: 'ing-lemon', name: 'Lemon', category: 'Fruit'),
  ];

  static final List<Recipe> recipes = [
    Recipe(
      id: 'recipe-dal-tadka',
      title: 'Dal Tadka',
      description:
          'Comforting yellow dal tempered with cumin, garlic and ghee.',
      category: 'Lunch',
      cookTimeMinutes: 35,
      servings: 4,
      difficulty: 'Easy',
      videoId: 'video-dal-tadka',
      imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-toor-dal',
          name: 'Toor dal',
          quantity: '1',
          unit: 'cup',
        ),
        RecipeIngredient(
          ingredientId: 'ing-onion',
          name: 'Onion',
          quantity: '1',
          unit: 'medium',
        ),
        RecipeIngredient(
          ingredientId: 'ing-tomato',
          name: 'Tomato',
          quantity: '2',
        ),
        RecipeIngredient(
          ingredientId: 'ing-garlic',
          name: 'Garlic',
          quantity: '4',
          unit: 'cloves',
        ),
        RecipeIngredient(
          ingredientId: 'ing-cumin',
          name: 'Cumin',
          quantity: '1',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-turmeric',
          name: 'Turmeric',
          quantity: '1/2',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-ghee',
          name: 'Ghee',
          quantity: '1',
          unit: 'tbsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-salt',
          name: 'Salt',
          quantity: 'to taste',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction:
              'Wash the dal and pressure cook it with turmeric until soft.',
          durationMinutes: 15,
        ),
        CookingStep(
          order: 2,
          instruction:
              'Heat ghee. Add cumin and garlic. Then add onion and tomato.',
          durationMinutes: 8,
        ),
        CookingStep(
          order: 3,
          instruction: 'Mix the tempering into the dal. Add salt and simmer for 5 minutes.',
          durationMinutes: 5,
        ),
      ],
    ),
    Recipe(
      id: 'recipe-aloo-paratha',
      title: 'Aloo Paratha',
      description: 'Soft wheat flatbread stuffed with spiced potato.',
      category: 'Breakfast',
      cookTimeMinutes: 40,
      servings: 4,
      difficulty: 'Medium',
      videoId: 'video-aloo-paratha',
      imageUrl: 'https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-atta',
          name: 'Wheat flour',
          quantity: '2',
          unit: 'cups',
        ),
        RecipeIngredient(
          ingredientId: 'ing-potato',
          name: 'Potato',
          quantity: '3',
          unit: 'boiled',
        ),
        RecipeIngredient(
          ingredientId: 'ing-green-chilli',
          name: 'Green chilli',
          quantity: '2',
        ),
        RecipeIngredient(
          ingredientId: 'ing-cumin',
          name: 'Cumin',
          quantity: '1',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-ghee',
          name: 'Ghee',
          quantity: '2',
          unit: 'tbsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-salt',
          name: 'Salt',
          quantity: 'to taste',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction: 'Knead a soft dough with wheat flour, salt and water.',
          durationMinutes: 10,
        ),
        CookingStep(
          order: 2,
          instruction: 'Mash potatoes with chilli, cumin and salt.',
        ),
        CookingStep(
          order: 3,
          instruction: 'Fill dough balls with potato mix. Roll and cook on a tawa with ghee.',
          durationMinutes: 15,
        ),
      ],
    ),
    Recipe(
      id: 'recipe-veg-pulao',
      title: 'Vegetable Pulao',
      description: 'Fragrant rice cooked with vegetables and whole spices.',
      category: 'Lunch',
      cookTimeMinutes: 30,
      servings: 3,
      difficulty: 'Easy',
      videoId: 'video-veg-pulao',
      imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-rice',
          name: 'Rice',
          quantity: '1.5',
          unit: 'cups',
        ),
        RecipeIngredient(
          ingredientId: 'ing-onion',
          name: 'Onion',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-capsicum',
          name: 'Capsicum',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-potato',
          name: 'Potato',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-cumin',
          name: 'Cumin',
          quantity: '1',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-oil',
          name: 'Cooking oil',
          quantity: '2',
          unit: 'tbsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-salt',
          name: 'Salt',
          quantity: 'to taste',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction: 'Rinse rice and soak for 15 minutes.',
          durationMinutes: 15,
        ),
        CookingStep(
          order: 2,
          instruction: 'Sauté cumin, onion and vegetables in oil.',
          durationMinutes: 6,
        ),
        CookingStep(
          order: 3,
          instruction:
              'Add rice, water and salt. Cook until the rice is fluffy.',
          durationMinutes: 12,
        ),
      ],
    ),
    Recipe(
      id: 'recipe-palak-paneer',
      title: 'Palak Paneer',
      description: 'Paneer cubes in a mild spinach gravy.',
      category: 'Dinner',
      cookTimeMinutes: 45,
      servings: 4,
      difficulty: 'Medium',
      videoId: 'video-palak-paneer',
      imageUrl: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-spinach',
          name: 'Spinach',
          quantity: '1',
          unit: 'bunch',
        ),
        RecipeIngredient(
          ingredientId: 'ing-paneer',
          name: 'Paneer',
          quantity: '200',
          unit: 'g',
        ),
        RecipeIngredient(
          ingredientId: 'ing-onion',
          name: 'Onion',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-tomato',
          name: 'Tomato',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-garlic',
          name: 'Garlic',
          quantity: '4',
          unit: 'cloves',
        ),
        RecipeIngredient(
          ingredientId: 'ing-ginger',
          name: 'Ginger',
          quantity: '1',
          unit: 'inch',
        ),
        RecipeIngredient(
          ingredientId: 'ing-garam-masala',
          name: 'Garam masala',
          quantity: '1/2',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-oil',
          name: 'Cooking oil',
          quantity: '2',
          unit: 'tbsp',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction: 'Blanch spinach, then blend it into a smooth puree.',
          durationMinutes: 8,
        ),
        CookingStep(
          order: 2,
          instruction:
              'Cook onion, ginger, garlic and tomato. Add the spinach puree.',
          durationMinutes: 12,
        ),
        CookingStep(
          order: 3,
          instruction: 'Add paneer cubes and garam masala. Simmer gently.',
          durationMinutes: 6,
        ),
      ],
    ),
    Recipe(
      id: 'recipe-tomato-rasam',
      title: 'Tomato Rasam',
      description: 'Light, tangy South Indian soup with tomato and spices.',
      category: 'Soup',
      cookTimeMinutes: 25,
      servings: 4,
      difficulty: 'Easy',
      videoId: 'video-tomato-rasam',
      imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-tomato',
          name: 'Tomato',
          quantity: '3',
        ),
        RecipeIngredient(
          ingredientId: 'ing-garlic',
          name: 'Garlic',
          quantity: '3',
          unit: 'cloves',
        ),
        RecipeIngredient(
          ingredientId: 'ing-toor-dal',
          name: 'Toor dal',
          quantity: '2',
          unit: 'tbsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-cumin',
          name: 'Cumin',
          quantity: '1',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-mustard',
          name: 'Mustard seeds',
          quantity: '1/2',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-turmeric',
          name: 'Turmeric',
          quantity: '1/4',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-lemon',
          name: 'Lemon',
          quantity: '1/2',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction:
              'Boil tomatoes with garlic, turmeric and a little dal water.',
          durationMinutes: 10,
        ),
        CookingStep(
          order: 2,
          instruction: 'Mash the tomatoes. Add cumin and salt.',
        ),
        CookingStep(
          order: 3,
          instruction: 'Temper mustard seeds. Finish with lemon juice.',
          durationMinutes: 3,
        ),
      ],
    ),
    Recipe(
      id: 'recipe-curd-rice',
      title: 'Curd Rice',
      description: 'Cooling rice mixed with curd and a simple tempering.',
      category: 'Lunch',
      cookTimeMinutes: 20,
      servings: 2,
      difficulty: 'Easy',
      imageUrl: 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=800&q=80',
      ingredients: const [
        RecipeIngredient(
          ingredientId: 'ing-rice',
          name: 'Rice',
          quantity: '1',
          unit: 'cup',
        ),
        RecipeIngredient(
          ingredientId: 'ing-curd',
          name: 'Curd',
          quantity: '1',
          unit: 'cup',
        ),
        RecipeIngredient(
          ingredientId: 'ing-mustard',
          name: 'Mustard seeds',
          quantity: '1/2',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-green-chilli',
          name: 'Green chilli',
          quantity: '1',
        ),
        RecipeIngredient(
          ingredientId: 'ing-oil',
          name: 'Cooking oil',
          quantity: '1',
          unit: 'tsp',
        ),
        RecipeIngredient(
          ingredientId: 'ing-salt',
          name: 'Salt',
          quantity: 'to taste',
        ),
      ],
      steps: const [
        CookingStep(
          order: 1,
          instruction: 'Cook rice until soft and let it cool a little.',
          durationMinutes: 12,
        ),
        CookingStep(
          order: 2,
          instruction:
              'Mix curd, salt and a splash of milk or water if needed.',
        ),
        CookingStep(
          order: 3,
          instruction: 'Add a mustard and chilli tempering. Serve cool.',
        ),
      ],
    ),
  ];

  static const List<Video> videos = [
    Video(
      id: 'video-dal-tadka',
      recipeId: 'recipe-dal-tadka',
      title: 'Easy Dal Tadka at home',
      youtubeVideoId: 'mock-yt-dal-tadka',
      channelName: 'Home Kitchen',
    ),
    Video(
      id: 'video-aloo-paratha',
      recipeId: 'recipe-aloo-paratha',
      title: 'Soft Aloo Paratha',
      youtubeVideoId: 'mock-yt-aloo-paratha',
      channelName: 'Home Kitchen',
    ),
    Video(
      id: 'video-veg-pulao',
      recipeId: 'recipe-veg-pulao',
      title: 'One-pot Vegetable Pulao',
      youtubeVideoId: 'mock-yt-veg-pulao',
      channelName: 'Home Kitchen',
    ),
    Video(
      id: 'video-palak-paneer',
      recipeId: 'recipe-palak-paneer',
      title: 'Restaurant-style Palak Paneer',
      youtubeVideoId: 'mock-yt-palak-paneer',
      channelName: 'Home Kitchen',
    ),
    Video(
      id: 'video-tomato-rasam',
      recipeId: 'recipe-tomato-rasam',
      title: 'Quick Tomato Rasam',
      youtubeVideoId: 'mock-yt-tomato-rasam',
      channelName: 'Home Kitchen',
    ),
  ];
}
