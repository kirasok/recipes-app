import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavBarItem { recipes, shopping }

class NavigationState extends Equatable {
  final NavBarItem navBarItem;
  final int index;

  const NavigationState(this.navBarItem, this.index);

  @override
  List<Object> get props => [navBarItem, index];
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavBarItem.recipes, 0));

  void getNavBarItem(NavBarItem navBarItem) {
    switch (navBarItem) {
      case NavBarItem.recipes:
        emit(const NavigationState(NavBarItem.recipes, 0));
        break;
      case NavBarItem.shopping:
        emit(const NavigationState(NavBarItem.shopping, 1));
        break;
    }
  }
}
