import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:recipes/ui/screen/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (light, dark) => MaterialApp(
          title: 'Recipes',
          theme: ThemeData(
            colorScheme: light ??
                ColorScheme.fromSeed(
                  seedColor: const Color(0xffe15a29),
                  brightness: Brightness.light,
                ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: dark ??
                ColorScheme.fromSeed(
                  seedColor: const Color(0xffe15a29),
                  brightness: Brightness.dark,
                ),
            useMaterial3: true,
          ),
          home: const RootScreen(),
        ),
      );
}
