import '../../../models/last_news_model.dart';
import '../../../models/advantages_model.dart';
import '../../../models/houses_model.dart';
import '../../../models/reservations_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeGetAdsLoadingState extends HomeStates {}

class HomeGetAdsSuccessState extends HomeStates {
  final List<Results> lastNews;

  HomeGetAdsSuccessState(this.lastNews);
}

class HomeGetAdsErrorState extends HomeStates {
  final String error;

  HomeGetAdsErrorState(this.error);
}


class HomeGetAdvantagesLoadingState extends HomeStates {}

class HomeGetAdvantagesSuccessState extends HomeStates {
  final List<ResultsAdvantages> advantages;

  HomeGetAdvantagesSuccessState(this.advantages);
}

class HomeGetAdvantagesErrorState extends HomeStates {
  final String error;

  HomeGetAdvantagesErrorState(this.error);
}





class HomeGetHousesLoadingState extends HomeStates {}

class HomeGetHousesSuccessState extends HomeStates {
  final List<Data> houses;

  HomeGetHousesSuccessState(this.houses);
}

class HomeGetHousesErrorState extends HomeStates {
  final String error;

  HomeGetHousesErrorState(this.error);
}



class HomeGetReservationsLoadingState extends HomeStates {}

class HomeGetReservationsSuccessState extends HomeStates {
  final ReservationsModel reservationsModel;

  HomeGetReservationsSuccessState(this.reservationsModel);
}

class HomeGetReservationsErrorState extends HomeStates {
  final String error;

  HomeGetReservationsErrorState(this.error);
}



