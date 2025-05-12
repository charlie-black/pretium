import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/custom_logger.dart';




class EntityRepository {
  final dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    );

  Future<int?> entity({
    required String callingCode,
    required String phoneNumber,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.first == ConnectivityResult.none) {
        throw NoInternetException();
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var requestData = json.encode({
        "calling_code": callingCode,
        "phone": phoneNumber,
      });
      var res = await dio.post(
        "",
        data: requestData,
        options: Options(
          headers: {
            'Access-Control-Allow-Origin': '*',
            'content': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        await _saveEntityResponseData(res.data);

        return res.statusCode;
      } else {
        AppLogger.appLogE(
            tag: "Error:",
            message:
                "Entity Failed with status: ${res.statusCode}");
        return res.statusCode;
      }
    } on DioException catch (dioError) {

      if (dioError.response != null && dioError.response?.data != null) {
        final errorMessage = dioError.response?.data['message'] ?? 'Entity failed';
        throw errorMessage;
      } else if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.error is SocketException) {
        throw NoInternetException();
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException();
      } else {
        throw Exception('Error: ${dioError.message}');
      }
    } catch (e) {
      AppLogger.appLogE(
          tag: "Entity Error:", message: e.toString());
      rethrow;
    }
  }

  Future<void> _saveEntityResponseData(
      dynamic apiResponseData) async {
    try {
      final String jsonResponseData = json.encode(apiResponseData);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('entity_response_data', jsonResponseData);
    } catch (e) {
      AppLogger.appLogE(tag: "Entity data saving Error:", message: e.toString());
    }
  }

  Future<Map<String, dynamic>?> getEntityResponseData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? loginResponse =
          prefs.getString('entity_response_data');

      if (loginResponse != null) {
        final Map<String, dynamic> responseData = json.decode(loginResponse);
        return responseData;
      } else {
        AppLogger.appLogE(
            tag: "Error:", message: "No entity response found");
        return null;
      }
    } catch (e) {
      AppLogger.appLogE(tag: "Error:", message: e.toString());
      return null;
    }
  }
}

class NoInternetException implements Exception {}

class TimeoutException implements Exception {}
