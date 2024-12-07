import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/layout/cubit/state.dart';

import '../../modules/favorite/favorite_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/search/search_screen.dart';

class FoodCubit extends Cubit<FoodStates> {
  FoodCubit() : super(FoodInitialState());

  static FoodCubit get(context) => BlocProvider.of(context);

  int currentIndex = 4;

  List<Widget> bottomScreens = [
     HomeScreen(),
     SearchScreen(),
    const Text("canter"),
     FavoriteScreen(),
     ProfileScreen(),
  ];

  void changeBottom(int index) {
    if (index == 2) {
      emit(FoodChangeBottomNavState());
    } else {
      currentIndex = index;
      emit(FoodNewPostNavState());
    }
  }
}