import 'package:cooklang/cooklang.dart';
import 'package:flutter/services.dart';
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

  Future<List<Recipe>> get() async {
    if (await LocalStorage().isEmpty()) await LocalStorage().seed();
    final recipesRaw = await LocalStorage().getRecipes();
    List<Recipe> recipes = [];
    for (final recipe in recipesRaw) {
      recipes.add(parseFromString(recipe));
    }
    return recipes;
  }
}
