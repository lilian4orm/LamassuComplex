import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/home/cubit/state.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import '../../../models/last_news_model.dart';
import '../../../models/advantages_model.dart';
import '../../../models/houses_model.dart';
import '../../../models/reservations_model.dart';
import '../../../shared/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Results>? lastNews;
  List<ResultsAdvantages>? advantages;

  void getLastNews() async {
    emit(HomeGetAdsLoadingState());

    var headers = {
      'center_id': CanterId,
    };

    try {
      var response = await performRequest(
        'GET',
        '$lastNewsLink',
        headers,
      );

      if (response.statusCode == 200) {
        List<Results> lastNewsCome = (response.data['results'] as List)
            .map((json) => Results.fromJson(json))
            .toList();

        this.lastNews = lastNewsCome;
        emit(HomeGetAdsSuccessState(lastNewsCome));
      } else {
        emit(HomeGetAdsErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(HomeGetAdsErrorState('Error: $e'));
    }
  }

  void getAdvantages() async {
    emit(HomeGetAdvantagesLoadingState());

    var headers = {
      'center_id': CanterId,
    };

    try {
      var response = await performRequest(
        'GET',
        '$AdvantagesPoint',
        headers,
      );

      if (response.statusCode == 200) {
        List<ResultsAdvantages> advantages = (response.data['results'] as List)
            .map((json) => ResultsAdvantages.fromJson(json))
            .toList();

        this.advantages = advantages;
        emit(HomeGetAdvantagesSuccessState(advantages));
      } else {
        emit(HomeGetAdvantagesErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(HomeGetAdvantagesErrorState('Error: $e'));
    }
  }

  void postReservations(
      String name, String phone, String address, String houseId) async {
    emit(HomeGetReservationsLoadingState());

    var headers = {
      'center_id': CanterId,
      'Content-Type': 'application/json',
    };

    var data = {
      "name": name,
      "phone": phone,
      "address": address,
      "house_id": houseId,
      "center_id": CanterId,
    };

    try {
      var response = await performRequest(
        'POST',
        '$ReservationsPoint',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        final ReservationsModel reservationsModel =
            ReservationsModel.fromJson(response.data);
        emit(HomeGetReservationsSuccessState(reservationsModel));
      } else {
        emit(HomeGetReservationsErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(HomeGetReservationsErrorState("Error: $e"));
    }
  }

  List<Data>? houses = [];

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  List<Data>? houses2 = [];
  List<Data>? houses3 = [];

  void getHouses(String search, String type) async {
    emit(HomeGetHousesLoadingState());
    await _fetchHouses(
        page: 1, search: search, type: type, isInitialLoad: true);
  }

  void loadMore(String search, String type) async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    currentPage++;
    await _fetchHouses(
        page: currentPage, search: search, type: type, isInitialLoad: false);
    isLoadingMore = false;
  }

  Future<void> _fetchHouses({
    required int page,
    required String search,
    required String type,
    required bool isInitialLoad,
  }) async {
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest(
        'GET',
        'houses?page=$page&limit=10&existing_type=$type',
        headers,
        queryParameters: {'search': search},
      );

      if (response.statusCode == 200) {
        var housesModel = HousesModel.fromJson(response.data);

        if (housesModel.results != null && housesModel.results!.data != null) {
          List<Data> fetchedHouses = housesModel.results!.data!;

          if (isInitialLoad) {
            _assignFetchedHouses(type, fetchedHouses, true);
          } else {
            _assignFetchedHouses(type, fetchedHouses, false);
          }

          if (fetchedHouses.length < 10) {
            hasMore = false;
          }

          emit(HomeGetHousesSuccessState(_getHousesListByType(type)!));
        } else {
          emit(HomeGetHousesErrorState(
              "Invalid response format: 'results.data' is null or not a List"));
        }
      } else {
        emit(HomeGetHousesErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(HomeGetHousesErrorState('Error: $e'));
    }
  }

  void _assignFetchedHouses(
      String type, List<Data> fetchedHouses, bool isInitialLoad) {
    switch (type) {
      case 'بيع':
        if (isInitialLoad) {
          houses2 = fetchedHouses;
        } else {
          houses2!.addAll(fetchedHouses);
        }
        break;
      case 'ايجار':
        if (isInitialLoad) {
          houses3 = fetchedHouses;
        } else {
          houses3!.addAll(fetchedHouses);
        }
        break;
      case ' ':
      default:
        if (isInitialLoad) {
          houses = fetchedHouses;
        } else {
          houses!.addAll(fetchedHouses);
        }
        break;
    }
  }

  List<Data>? _getHousesListByType(String type) {
    switch (type) {
      case 'بيع':
        return houses2;
      case 'ايجار':
        return houses3;
      case ' ':
      default:
        return houses;
    }
  }
}
