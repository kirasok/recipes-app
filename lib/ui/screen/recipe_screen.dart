import 'package:cooklang/cooklang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/data/model/recipe.dart';
import 'package:recipes/logic/cubit/recipe_cubit.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<RecipeCubit, TitledRecipe>(
        builder: (context, state) {
          final image = state.images?.first;
          List<Widget> steps = [];
          for (final step in state.steps) {
            steps.add(_step(context, step));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(state.title),
            ),
            body: ListView(
              children: [
                    image != null
                        ? FittedBox(
                            fit: BoxFit.fill,
                            child: Image.memory(image),
                          )
                        : Container(),
                  ] +
                  steps,
            ),
          );
        },
      );

  Widget _step(BuildContext context, List<StepItem> step) {
    final style = Theme.of(context).textTheme.bodyMedium;
    List<TextSpan> items = [];
    for (final part in step) {
      if (part is StepText) {
        items.add(
          TextSpan(text: part.value, style: style),
        );
      }
      if (part is StepCookware) {
        items.add(
          TextSpan(
            text: "${part.quantity} ${part.name}",
            style: style?.copyWith(color: Colors.yellow.shade800),
          ),
        );
      }
      if (part is StepTimer) {
        items.add(
          TextSpan(
            text: "${part.quantity} ${part.units} ${part.name}",
            style: style?.copyWith(color: Colors.green.shade800),
          ),
        );
      }
      if (part is StepIngredient) {
        items.add(
          TextSpan(
            text:
                // TODO: fix cases when quantity equals 0.x
                "${part.quantity is double ? part.quantity.toInt() : part.quantity} ${part.units} ${part.name}",
            style: style?.copyWith(color: Colors.orange.shade800),
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(text: TextSpan(children: items)),
    );
  }
}
