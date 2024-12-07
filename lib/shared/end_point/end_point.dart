import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'https://api.myexperience.center/api/mobile/';
String imageStorg = "https://api.myexperience.center/storage/";
String CanterId = "6638d6a4c8462a1d83346b54";
const String HousesPoint = "houses";
String lastNewsLink = "ads";
const String AdvantagesPoint = "advantages";
const String ReservationsPoint = "reservations";
const String FavoritePoint = "houses/by_ids";
const String centerA = "center";
const String salaryOwner = "salary_owner";
const String authLogin = "auth/login";
const String sellsEmployeeCallCenter = "sellsEmployee/call_center";
const String sellsEmployeeApplicationForm = "sellsEmployee/application_form";
const String notifications = "notifications";
const String ownerProfileA = "owner/profile";
const String rentProfileA = "tenant/profile";
const String sellsEmployeeProfile = "sellsEmployee/profile";
const String ownerProfileEditImg = "owner/profile/edit_img";
const String sellsEmployeeProfileEditImg = "sellsEmployee/profile/edit_img";
const String guardProfileA = "guard/profile";
const String guardProfileEditImg = "guard/profile/edit_img";
const String guardCheck_qr = "guard/check_qr";
const String services = "services";
const String reservationsService = "reservations/service";
const String salaryOwnerServices = "salary_owner/services";
const String ownerQrGenerate = "owner/qr_generate";
const String centerFormsEndPoint = "center/forms";
const String howHearAboutUsEndPoint = "sellsEmployee/how_u_hear_about_us";
const String sellsEmployeeCall_centerEndPoint = "sellsEmployee/call_center";
const String serviceReqquest = "reservations/service";
const String electricUsageLink = "owner/electricity/usage";

const String centerFormsNames = "center/forms/names";
const String centerFormsHouses = "center/forms/houses/";
const String centerFormsHousesRooms = "center/forms/houses/rooms/";

const String sellsEmployeeConfirmationsFormEndPoint =
    "sellsEmployee/confirmations_form";

followTopics() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? gest = prefs.getString('gest');
  String? owner = prefs.getString('owner');
  String? guard = prefs.getString('guard');
  String? maintance = prefs.getString('maintenance');
  String? sells = prefs.getString('sells_emp');
  String? rent = prefs.getString('rent');
  String? investor = prefs.getString('investor');
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.subscribeToTopic('complex_$CanterId');

    if (owner != null) {
      print('all_owners');
      await messaging.subscribeToTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (investor != null) {
      print('all_investors');
      await messaging.subscribeToTopic('all_investors_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (rent != null) {
      print(rent);
      print('all_rents');
      await messaging.subscribeToTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (sells != null) {
      print('all_employees');
      await messaging.subscribeToTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (gest != null) {
      print('all_guests');
      await messaging.subscribeToTopic('all_guests_$CanterId');
      await messaging.subscribeToTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (guard != null) {
      print('all_guards');
      await messaging.subscribeToTopic('all_guards_$CanterId');
      await messaging.subscribeToTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    } else if (maintance != null) {
      print('all_maintances');
      await messaging.subscribeToTopic('all_maintances_$CanterId');
      await messaging.subscribeToTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
    } else {
      print('all');
      await messaging.unsubscribeFromTopic('complex_$CanterId');
      await messaging.unsubscribeFromTopic('all_owners_$CanterId');
      await messaging.unsubscribeFromTopic('all_rents_$CanterId');
      await messaging.unsubscribeFromTopic('all_employees_$CanterId');
      await messaging.unsubscribeFromTopic('all_guests_$CanterId');
      await messaging.unsubscribeFromTopic('all_guards_$CanterId');
      await messaging.unsubscribeFromTopic('all_maintances_$CanterId');
    }
  } catch (e) {
    print('error in followTopics: $e');
  }
}
