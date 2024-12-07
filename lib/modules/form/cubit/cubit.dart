import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:lamassu/modules/form/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/apartment/apartment_tower_floor_model.dart';
import '../../../models/apartment/apartment_towers_model.dart';
import '../../../models/apartment/towers_floors_model.dart';
import '../../../models/form_model/form_houses.dart';
import '../../../models/form_model/form_name.dart';
import '../../../models/how_hear_about.dart';
import '../../../models/show_application_form_model.dart';
import '../../../models/show_apply_form_model.dart';
import '../../../models/show_customer_form_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';

class FormCubit extends Cubit<FormAStates> {
  FormCubit() : super(FormInitialState());

  static FormCubit get(context) => BlocProvider.of(context);

  void postCustomerForm({
    required String caller_name,
    required String caller_phone,
    required String caller_job,
    required String caller_governorate,
    required String caller_address,
    required int family_members,
    required String about_us,
    required double space_required,
    required String call_reason,
    required String form_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(CustomerFormLoadingState());

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var data = {
      "caller_name": caller_name,
      "caller_phone": caller_phone,
      "caller_job": caller_job,
      "caller_governorate": caller_governorate,
      "caller_address": caller_address,
      "caller_family_members": family_members,
      "how_he_hear_about_us": about_us,
      "space_required": space_required,
      "call_reason": call_reason,
      "form_id": form_id
    };

    try {
      var response = await performRequest(
        'POST',
        '$sellsEmployeeCallCenter',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        emit(CustomerFormSuccessState());
      } else {
        emit(CustomerFormErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(CustomerFormErrorState("Error: $e"));
      print("Error: $e");
    }
  }

  void postApplicationForm({
    required String customer_name,
    required String customer_phone,
    required String customer_phone_two,
    required String id_number,
    required String id_issue_date,
    required String street,
    required String state,
    required String city,
    required String house,
    required String email,
    required int family_number,
    required String job,
    required String job_type,
    required String form_id,
    required String house_id,
    required int price,
    required String account_number,
    required String payment_type,
    required String price_written,
    required int management_fees,
    required int first_payment,
    required String id_front_image,
    required String id_back_image,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(CustomerFormLoadingState());

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var data = {
      "customer_name": customer_name,
      "customer_phone": customer_phone,
      "customer_phone_two": customer_phone_two,
      "id_number": id_number,
      "id_issue_date": id_issue_date,
      "street": street,
      "city": city,
      "state": state,
      "house": house,
      "email": email,
      "family_number": family_number,
      "job": job,
      "job_type": job_type,
      "form_id": form_id,
      "house_id": house_id,
      "price": price,
      "account_number": account_number,
      "payment_type": payment_type,
      "price_written": price_written,
      "management_fees": management_fees,
      "first_payment": first_payment,
      "id_front_image": id_front_image,
      "id_back_image": id_back_image
    };

    try {
      var response = await performRequest(
        'POST',
        '$sellsEmployeeApplicationForm',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        emit(CustomerFormSuccessState());
      } else {
        emit(CustomerFormErrorState(response.statusMessage ?? "Error"));
        // print("Erroreeeeeeeee: ${response.statusMessage}");
      }
    } catch (e) {
      emit(CustomerFormErrorState("Error: $e"));
      print("Errorddd: $e");
    }
  }

  howHearAbout? howHearData;
  void howHearAboutUs() async {
    emit(howHearLoadingState());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var headers = {'Authorization': token!};

      var response =
          await performRequest('GET', howHearAboutUsEndPoint, headers);

      var howHearAboutData = howHearAbout.fromJson(response.data);
      howHearData = howHearAboutData;

      emit(howHearSuccessState(howHearAboutData));
    } catch (e) {
      emit(howHearErrorState('Error: $e'));
      print('Errorddd: $e');
    }
  }

  FormNameModel? FormName2;

  void getFormName2() async {
    emit(FormName2LoadingState());
    print("FormNameLoadingState");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest('GET', centerFormsNames, headers);

      if (response.statusCode == 200) {
        FormName2 = FormNameModel.fromJson(response.data);
        this.FormName2 = FormName2;

        emit(FormName2SuccessState(FormName2));
      } else {
        emit(FormName2ErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (e) {
      print("Error in FormName2 : $e");
      emit(FormName2ErrorState('Error: $e'));
    }
  }

  HouseNmaeModel? HouseName2;
  void getHouseName2({required String? id}) async {
    emit(HouseName2LoadingState());
    print("FormNameLoadingState");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response =
          await performRequest('GET', "center/forms/houses/$id", headers);

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        HouseName2 = HouseNmaeModel.fromJson(response.data);
        this.HouseName2 = HouseName2;
        print("FormNameSuccessState");
        print(HouseName2!.results!.first.name!);

        emit(HouseName2SuccessState(HouseName2));
      } else {
        emit(HouseName2ErrorState('Error: Status code ${response.statusCode}'));
        print("uyfdvutcyfveuyfbcvf");
      }
    } catch (e) {
      print("Error in HouseName2: $e");
      emit(HouseName2ErrorState('Error: $e'));
    }
  }

  ShowCustomerFormModel? ShowCustomer;
  void getShowCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ShowCustomerFormsLoadingState());

    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
          'GET', sellsEmployeeCall_centerEndPoint, headers);

      if (response.statusCode == 200) {
        ShowCustomer = ShowCustomerFormModel.fromJson(response.data);
        print('===============================');
        print('qrGenerate : ${response.data['results']['data'].length}');

        emit(ShowCustomerFormsSuccessState(ShowCustomer!));
      } else {
        emit(ShowCustomerFormsErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(ShowCustomerFormsErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  ShowApplicationFormModel? showApplicationForm;
  void getShowApplicationForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ShowApplicationFormLoadingState());

    try {
      var headers = {'Authorization': token};

      var response =
          await performRequest('GET', sellsEmployeeApplicationForm, headers);

      if (response.statusCode == 200) {
        showApplicationForm = ShowApplicationFormModel.fromJson(response.data);
        print('ShowCustomerFormModel : $showApplicationForm');

        emit(ShowApplicationFormSuccessState(showApplicationForm));
      } else {
        emit(ShowApplicationFormErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(ShowApplicationFormErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  void editCustomerForm({
    required String idForm,
    required String caller_name,
    required String caller_phone,
    required String caller_governorate,
    required String caller_job,
    required String caller_address,
    required int family_members,
    required String about_us,
    required int space_required,
    required String call_reason,
    required String form_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(EditCustomerFormLoadingState());

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var data = {
      "caller_name": caller_name,
      "caller_phone": caller_phone,
      "caller_job": caller_job,
      "caller_governorate": caller_governorate,
      "caller_address": caller_address,
      "caller_family_members": family_members,
      "how_he_hear_about_us": about_us,
      "space_required": space_required,
      "call_reason": call_reason,
      "form_id": form_id
    };

    try {
      var response = await performRequest(
        'PUT',
        '$sellsEmployeeCall_centerEndPoint/$idForm',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        emit(EditCustomerFormSuccessState());
      } else {
        emit(EditCustomerFormErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(EditCustomerFormErrorState("Error: $e"));
    }
  }

  void postApplyForm({
    required String customer_name,
    required String customer_phone,
    required String type,
    required String form_id,
    required String house_id,
    required String details,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ApplyFormLoadingState());

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
      'Accept': 'application/json'
    };

    var data = {
      "customer_name": customer_name,
      "customer_phone": customer_phone,
      "type": type,
      "form_id": form_id,
      "house_id": house_id,
      "details": details,
    };
    Logger().d(data);

    try {
      var response = await performRequest(
        'POST',
        '$sellsEmployeeConfirmationsFormEndPoint',
        headers,
        data: data,
      );
      Logger().i(response.data);

      if (response.statusCode == 200) {
        emit(ApplyFormSuccessState());
      } else {
        emit(ApplyFormErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(ApplyFormErrorState("Error: $e"));
      print("Error: $e");
    }
  }

  void postApplyFormOwner({
    required String note,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ApplyFormLoadingState());

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
      'Accept': 'application/json'
    };

    var data = {
      "note": note,
    };
    Logger().d(data);

    try {
      var response = await performRequest(
        'POST',
        'owner_requests',
        headers,
        data: data,
      );
      Logger().i(response.data);

      if (response.statusCode == 200) {
        emit(ApplyFormSuccessState());
      } else {
        emit(ApplyFormErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(ApplyFormErrorState("Error: $e"));
      print("Error: $e");
    }
  }

  ShowApplyFormModel? showApply;
  void getShowShowApply() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ShowApplyFormsLoadingState());

    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
          'GET', sellsEmployeeConfirmationsFormEndPoint, headers);

      if (response.statusCode == 200) {
        showApply = ShowApplyFormModel.fromJson(response.data);
        print('tttttt : $showApply');

        emit(ShowApplyFormsSuccessState(showApply!));
      } else {
        emit(ShowApplyFormsErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(ShowApplyFormsErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  ////////////////////////////////////

  ApartmentTowersModel? Towers;

  void getTowers() async {
    emit(TowersLoadingState());
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response =
          await performRequest('GET', "center/forms/apartment/towers", headers);

      if (response.statusCode == 200) {
        Logger().i(response.data);
        Towers = ApartmentTowersModel.fromJson(response.data);
        this.Towers = Towers;

        emit(TowersSuccessState(Towers));
      } else {
        emit(TowersErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (e) {
      emit(TowersErrorState('Error: $e'));
    }
  }

  TowersFloorsModel? Floors;

  void getFloors({required String? id}) async {
    emit(FloorsLoadingState());
    print("FloorsLoadingState");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest(
          'GET', "/center/forms/apartment/towers/floors/$id", headers);

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        Floors = TowersFloorsModel.fromJson(response.data);
        this.Floors = Floors;
        print("Floors");
        print(Floors!.results!.first.apartmentFloorNumber!);

        emit(FloorsSuccessState(Floors));
      } else {
        emit(FloorsErrorState('Error: Status code ${response.statusCode}'));
        print("Floorserror");
      }
    } catch (e) {
      print("Error in FormName2 : $e");
      emit(FloorsErrorState('Error: $e'));
    }
  }

  ApartmentTowerAndFloorModel? ApartmentTowerFloor;

  void getApartmentTowerFloor(
      {required String? tower, required String? floor}) async {
    emit(ApartmentTowerFloorLoadingState());
    // print("ApartmentTowerAndFloorModel");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest(
          'GET', "center/forms/apartment/tower/$tower/floor/$floor", headers);

      // print("Response status code: ${response.statusCode}");
      // print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        ApartmentTowerFloor =
            ApartmentTowerAndFloorModel.fromJson(response.data);
        this.ApartmentTowerFloor = ApartmentTowerFloor;
        // print("ApartmentTowerAndFloorModel");
        // print(ApartmentTowerFloor!.results!.first.apartmentFloorNumber!);

        emit(ApartmentTowerFloorSuccessState(ApartmentTowerFloor));
      } else {
        emit(ApartmentTowerFloorErrorState(
            'Error: Status code ${response.statusCode}'));
        // print("ApartmentTowerAndFloorModel");
      }
    } catch (e) {
      print("Error in ApartmentTowerAndFloorModel : $e");
      emit(ApartmentTowerFloorErrorState('Error: $e'));
    }
  }

  void putTransferred({
    required String? sid,
  }) async {
    emit(TransferredLoadingState());
    print("ApartmentTowerAndFloorModel");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest(
          'PUT',
          "sellsEmployee/call_center/updateIsTransferredToApplicationForm/$sid",
          headers);

      if (response.statusCode == 200) {
        emit(TransferredSuccessState());
      } else {
        emit(
            TransferredErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (e) {
      emit(TransferredErrorState('Error: $e'));
    }
  }
}
