import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lamassu/models/service_model.dart';
import 'package:lamassu/modules/maintenance/log_out_button_widget.dart';
import 'package:lamassu/modules/maintenance/servie_card.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MaintanceHome extends StatefulWidget {
  const MaintanceHome({super.key});

  @override
  State<MaintanceHome> createState() => _MaintanceHomeState();
}

class _MaintanceHomeState extends State<MaintanceHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلبات الصيانة'),
        leading: LogoutButtonWidget(),
      ),
      body: FutureBuilder(
          future: getServicesRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                var data = snapshot.data["results"]["data"];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var service = ServiceModel.fromJson(data[index]);

                    return ServiceCard(service: service);
                  },
                );
              } else {
                return Text('No data');
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('has error'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

Future getServicesRequest() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token is null');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var main_url = 'https://api.myexperience.center/api/web/';
    var link =
        '$main_url$serviceReqquest?search=null&is_deleted=false&sortBy={"key": "createdAt", "order": "desc"}';

    var res = await http.get(Uri.parse(link), headers: headers);
    //print(res.body);

    return jsonDecode(res.body);
  } catch (e) {
    print("Error iiiii: $e");
  }
}
