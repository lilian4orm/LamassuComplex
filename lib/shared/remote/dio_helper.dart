import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../end_point/end_point.dart';

final Dio _dio = Dio();

Future<Response> performRequest(
    String method, String url, Map<String, dynamic> headers,
    {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
  try {
    Response response;
    if (method == 'GET') {
      response = await _dio.get(
        "${baseUrl + url}",
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
    } else if (method == 'POST') {
      response = await _dio.post(
        "${baseUrl + url}",
        data: data,
        options: Options(headers: headers),
      );
    } else if (method == 'PUT') {
      response = await _dio.put(
        "${baseUrl + url}",
        options: Options(headers: headers),
        data: data,
      );
    } else {
      throw Exception('Unsupported HTTP method');
    }

    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      deleteAllSharedPreferencesData();

      throw Exception('Unauthorized: Check your authentication credentials.');
    } else {
      throw Exception('Unauthorized Error: ${e.message}');
    }
  } catch (e) {
    throw Exception('authentication: $e');
  }
}

Future<void> deleteAllSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
