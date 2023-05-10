import 'package:flutter/services.dart';
import 'package:recipes/data/model/recipe.dart';
import 'package:recipes/data/storage/local_storage.dart';
import 'package:universal_platform/universal_platform.dart';

class RecipesRepository {
  static final RecipesRepository _instance = RecipesRepository._();

  RecipesRepository._() {
    if (UniversalPlatform.isWeb) {
      // TODO: use file_system_access_api
      throw PlatformException(
          code: "400", message: "Web is currently not supported");
    }
  }

  factory RecipesRepository() => _instance;

  Future<List<TitledRecipe>> get() async {
    if (await LocalStorage().isEmpty()) await LocalStorage().seed();
    final rawRecipes = await LocalStorage().getRecipes();
    List<TitledRecipe> recipes = [];
    for (final title in rawRecipes.keys) {
      recipes.add(
          TitledRecipe.parseFromStringTitled(title, rawRecipes[title] ?? ""));
    }
    return recipes;
  }
}
