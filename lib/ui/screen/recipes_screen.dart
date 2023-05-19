import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/logic/cubit/recipes_cubit.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) => BlocBuilder<RecipesCubit, RecipesState>(
        builder: (context, state) {
          if (state is RecipesLoaded) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final image = state.recipes[index].images?.first;
                  return SizedBox(
                    child: ListTile(
                        minLeadingWidth: 56,
                        leading: image != null
                            ? Image.memory(
                                image,
                                width: 56,
                                height: 56,
                              )
                            : const SizedBox(),
                        title: Text(state.recipes[index].title)),
                  );
                },
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
      );
}
