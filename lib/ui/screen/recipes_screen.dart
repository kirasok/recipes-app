import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/logic/cubit/recipes_cubit.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<FileSystemEntity> data = [];

  @override
  Widget build(BuildContext context) => BlocProvider<RecipesCubit>(
        create: (context) => RecipesCubit(),
        child: BlocBuilder<RecipesCubit, RecipesState>(
          builder: (context, state) {
            if (state is RecipesLoaded) {
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                      title: Text(state.recipes[index].metadata.values.first)),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.recipes.length);
            } else if (state is RecipesLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const Text("Something went wrong!");
            }
          },
        ),
      );
}
