
import 'package:pretium/utils/templates/get_details/repository/property_details_api_provider.dart';
import '../../../../../utils/api_response.dart';

class PropertyDetailsApiRepository {
  final _provider = PropertyDetailsApiProvider();
  Future<ApiResponse> getPropertyDetails(String propertyCode) {
    return _provider.getPropertyDetails(propertyCode: propertyCode);
  }
}

class NetworkError extends Error {}
