import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final _logger = Logger();
  static final _instance = LocalStorage._();
  LocalStorage._() {
    root.then((value) {
      _logger.d("Documents directory path: ${value.path}");
      recipesDir = Directory("${value.path}/recipes");
      recipesDir.createSync();
      _logger.d("Recipe directory path: ${recipesDir.path}");
    });
  }
  factory LocalStorage() => _instance;

  final root = getApplicationDocumentsDirectory();
  late Directory recipesDir;

  Future<Map<String, String>> getRecipes() async {
    await root;
    _logger.d("Got dir ${recipesDir.listSync()}");
    Map<String, String> recipes = {};
    final files = recipesDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((element) => element.path.endsWith(".cook"));
    for (final file in files) {
      final recipe = file.readAsStringSync();
      final title = file.path.split("/").last.replaceAll(".cook", "");
      recipes[title] = recipe;
    }
    _logger.d("Read recipes: $recipes");
    return recipes;
  }

  Future<bool> isEmpty() async {
    await root;
    final isEmpty = recipesDir.listSync(recursive: true).isEmpty;
    _logger.d("Recipes are empty: $isEmpty");
    return isEmpty;
  }

  Future<void> seed() async {
    await root;
    _logger.d("Seeding recipes");
    final assets =
        jsonDecode(await rootBundle.loadString('AssetManifest.json')) as Map;
    _logger.d("Got assets: $assets");

    final cook =
        assets.keys.where((element) => element.endsWith(".cook")).toList();
    _logger.d("Got cook: $cook");
    for (final String key in cook) {
      final filename = key.substring(7); // Because key is recipes/file.cook
      _logger.d("Seeding $key");
      final content = await rootBundle.loadString(key);
      _logger.d("While seeding $key, found content: $content");
      write(filename, content);
    }

    final jpg =
        assets.keys.where((element) => element.endsWith(".jpg")).toList();
    _logger.d("Got jpg: $jpg");
    for (final String key in jpg) {
      final filename = key.substring(7); // Because key is recipes/file.cook
      _logger.d("Seeding $key");
      final content = await rootBundle.load(key);
      writeByte(filename, content);
    }
  }

  Future<void> write(final String filename, final String content) async {
    await root;
    final file = File("${recipesDir.path}/$filename");
    _logger.d("Writing file $filename with content $content");
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
  }

  Future<void> writeByte(final String filename, final ByteData content) async {
    await root;
    final file = File("${recipesDir.path}/$filename");
    _logger.d("Writing binary file $filename");
    file.createSync();
    final buffer = content.buffer;
    file.writeAsBytesSync(
        buffer.asUint8List(content.offsetInBytes, content.lengthInBytes));
  }
}
