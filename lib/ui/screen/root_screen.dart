import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/logic/cubit/navigation_cubit.dart';
import 'package:recipes/logic/cubit/recipes_cubit.dart';
import 'package:recipes/ui/screen/recipes_screen.dart';
import 'package:recipes/ui/screen/shopping_list_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<RecipesCubit>(create: (context) => RecipesCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) => NavigationBar(
            selectedIndex: state.index,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.view_list_outlined),
                selectedIcon: Icon(Icons.view_list),
                label: 'Recipes',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart),
                label: 'Shopping List',
              ),
            ],
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.recipes);
                  break;
                case 1:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.shopping);
                  break;
                default:
                  throw Exception("Unknown index: $index");
              }
            },
          ),
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            switch (state.navBarItem) {
              case NavBarItem.recipes:
                return const RecipesScreen();
              case NavBarItem.shopping:
                return const ShoppingListScreen();
              default:
                return const Text("Loading");
            }
          },
        ),
      ),
    );
  }
}
