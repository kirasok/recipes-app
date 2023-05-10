import 'package:cooklang/cooklang.dart';

class TitledRecipe extends Recipe {
  final String title;
  TitledRecipe(this.title, List<Step> steps, Metadata metadata)
      : super(steps, metadata);

  static TitledRecipe parseFromStringTitled(String title, String content) {
    final recipe = parseFromString(content);
    return TitledRecipe(title, recipe.steps, recipe.metadata);
  }
}
