import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custom_logger.dart';
import '../model/all_reservations_model.dart';


class AllReservationsRepository {
  final dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
    );

  Future<List<AllReservationsModel>> getReservations({
    required bool showPayments,



  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");
      var requestData = json.encode({
        "show_payments": showPayments

      });

      if (connectivityResult.first == ConnectivityResult.none) {
        throw NoInternetException();
      }
      print(requestData);

      var res = await dio.post(
        "",
        data: requestData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Access-Control-Allow-Origin': '*',
            'content': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        if (res.data != null && res.data['content'] != null) {
          List<AllReservationsModel> properties = (res.data['content'] as List)
              .map((jsonItem) => AllReservationsModel.fromJson(jsonItem))
              .toList();

          return properties;
        } else {
          AppLogger.appLogE(
              tag: "Error:", message: "No content found in response");
          return [];
        }
      } else {
        AppLogger.appLogE(
            tag: "Error:",
            message: "Failed to get reservations: ${res.statusCode}");
        return [];
      }
    }on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        final errorMessage =
            dioError.response?.data['message'] ?? 'Fetch reservations failed';
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
      AppLogger.appLogE(tag: "Fetch reservations Error:", message: e.toString());
      rethrow;
    }
  }
}

class NoInternetException implements Exception {
  @override
  String toString() => "No internet connection";
}

class TimeoutException implements Exception {
  @override
  String toString() => "Request timed out";
}
