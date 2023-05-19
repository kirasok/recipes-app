import 'dart:typed_data';

import 'package:cooklang/cooklang.dart';

class TitledRecipe extends Recipe {
  final String title;
  final List<Uint8List>? images;
  TitledRecipe(this.title, List<Step> steps, Metadata metadata, {this.images})
      : super(steps, metadata);

  static TitledRecipe parseFromStringTitled(
      String title, String content, List<Uint8List>? images) {
    final recipe = parseFromString(content);
    return TitledRecipe(title, recipe.steps, recipe.metadata, images: images);
  }
}
