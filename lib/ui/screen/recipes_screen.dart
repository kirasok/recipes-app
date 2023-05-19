import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/logic/cubit/recipe_cubit.dart';
import 'package:recipes/logic/cubit/recipes_cubit.dart';
import 'package:recipes/ui/screen/recipe_screen.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

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
                      title: Text(state.recipes[index].title),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => RecipeCubit(state.recipes[index]),
                              child: const RecipeScreen(),
                            ),
                          ),
                        );
                      },
                    ),
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
