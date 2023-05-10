import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipes/data/model/recipe.dart';
import 'package:recipes/data/repository/recipe_repository.dart';

abstract class RecipesState {}

class RecipesLoaded extends RecipesState {
  List<TitledRecipe> recipes;
  RecipesLoaded(this.recipes);
}

class RecipesLoading extends RecipesState {}

class RecipesFailed extends RecipesState {
  Object e;
  RecipesFailed(this.e) {
    Logger().e(e);
  }
}

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit() : super(RecipesLoading()) {
    try {
      loadRecipes();
    } catch (e) {
      emit(RecipesFailed(e));
    }
  }

  Future<void> loadRecipes() =>
      RecipesRepository().get().then((value) => emit(RecipesLoaded(value)));
}
