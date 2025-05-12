import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../custom_logger.dart';
import '../model/search_property_listing_model.dart';


class SearchPropertyListingRepository {
  final dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
    );

  Future<List<SearchPropertyListingModel>> getStays({
    required double latitude,
    required double longitude,
    required List propertyTypes,
    required List amenitiesId,
    required int numberOfGuests,
    required int numberOfBeds,
    required int numberOfBathrooms,
    required int numberOfBedrooms,
    required String searchType


  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");
      var requestData = json.encode({
        "location": {
          "lat": latitude,
          "lng": longitude
        },
        "limit": 100,
        "detailed_payload": false,
        "search_radius": 1000,
        "number_of_guests": numberOfGuests,
        "number_of_beds": numberOfBeds,
        "number_of_bathrooms": numberOfBathrooms,
        "number_of_bedrooms": numberOfBedrooms,
        "amenities": amenitiesId,
        "property_types": propertyTypes,
      });

      var broadRequestData = json.encode({
        "location": {
          "lat": latitude,
          "lng": longitude
        },
        "limit": 100,
        "detailed_payload": false,
        "search_radius": 1000,
        "property_types": propertyTypes,

      });

      if (connectivityResult.first == ConnectivityResult.none) {
        throw NoInternetException();
      }
      print(requestData);

      var res = await dio.post(
        "",
        data: searchType=="fixed"?requestData:broadRequestData,
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
          List<SearchPropertyListingModel> properties = (res.data['content'] as List)
              .map((jsonItem) => SearchPropertyListingModel.fromJson(jsonItem))
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
            message: "Failed to get properties: ${res.statusCode}");
        return [];
      }
    }on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        final errorMessage =
            dioError.response?.data['message'] ?? 'Search failed';
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
      AppLogger.appLogE(tag: "Search properties Error:", message: e.toString());
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
