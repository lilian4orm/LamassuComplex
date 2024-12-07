import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/favorite/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/houses_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';


class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<Data>? favoriteModel;

  Future<void> getFavorite() async {
    emit(FavoriteGetFavoriteLoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? housesIds = prefs.getStringList('houses_ids');

    try {
      var headers = {
        'center_id': CanterId,
        'Content-Type': 'application/json',
      };

      var data = {'houses_ids': housesIds};

      var response = await performRequest(
        'POST',
        '$FavoritePoint',
        headers,
        data: data,
      );


      if (response.statusCode == 200) {
        if (response.data != null) {
          favoriteModel = (response.data['results'] as List)
              .map((json) => Data.fromJson(json))
              .toList();
          emit(FavoriteGetFavoriteSuccessState(favoriteModel!));
        } else {

          emit(FavoriteGetFavoriteErrorState("Response data is null"));
        }
      } else {
        emit(FavoriteGetFavoriteErrorState(response.statusMessage!));
      }
    } catch (e) {
      emit(FavoriteGetFavoriteErrorState('Error: $e'));
    }
  }

  Future<void> removeFromFavorites(String houseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? housesIds = prefs.getStringList('houses_ids');

    if (housesIds != null) {
      housesIds.remove(houseId);
      await prefs.setStringList('houses_ids', housesIds);
    }

    // Call getFavorite method again to refresh the favorite list
    await getFavorite();
  }
}