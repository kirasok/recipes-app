import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final _logger = Logger();
  static final _instance = LocalStorage._();
  LocalStorage._();
  factory LocalStorage() => _instance;

  Future<List<String>> getRecipes() async {
    _logger.d("Getting documents directory");
    final root = await getApplicationDocumentsDirectory();
    _logger.d("Documents directory path: ${root.path}");
    final dir = await Directory("${root.path}/recipes").create();
    _logger.d("Recipe directory path: ${dir.path}");
    Logger().d("Got dir ${dir.listSync()}");
    List<String> recipes = [];
    for (var file in dir.listSync(recursive: true).whereType<File>()) {
      var recipe = file.readAsStringSync();
      recipes.add(recipe);
    }
    return recipes;
  }
}
