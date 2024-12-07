


import '../../../models/houses_model.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteGetFavoriteLoadingState extends FavoriteStates {}

class FavoriteGetFavoriteSuccessState extends FavoriteStates {
  final List<Data> Favorite;

  FavoriteGetFavoriteSuccessState(this.Favorite);
}

class FavoriteGetFavoriteErrorState extends FavoriteStates {
  final String error;

  FavoriteGetFavoriteErrorState(this.error);
}





