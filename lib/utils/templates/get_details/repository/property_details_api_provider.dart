import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_response.dart';
import '../model/property_details.dart';

class PropertyDetailsApiProvider {
  final Dio _dio = Dio();

  Future<ApiResponse> getPropertyDetails({required String propertyCode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var tokenStr = sharedPreferences.getString('token');

    try {
      Response response = await _dio.get(
        "",
        options: Options(
          headers: {
            'Authorization': 'Bearer $tokenStr',
          },
        ),
      );
      print(response.data);

      return ApiResponse(
        content: PropertyDetailsModel.fromJson(response.data['content']),
        errorMessage: "",
      );
    } catch (error, stacktrace) {
      return ApiResponse(
        content: null,
        errorMessage: error.toString(),
      );
    }
  }
}
