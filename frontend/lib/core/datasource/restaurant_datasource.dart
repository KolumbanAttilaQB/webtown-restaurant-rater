import 'package:restaurantapp/core/api/api_client.dart';
import 'package:restaurantapp/core/interface/restaurant_datasource_interface.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';
import 'package:restaurantapp/utils/settings/app_settings.dart';

class RestaurantDataSource extends RestaurantDatasourceInterface{
  @override
  Future<List<Restaurant>> getRestaurantList() async {
    try {
      var response = await ApiClient.shared.dio.get(
        '${AppSettings.BASE_URL}${AppSettings.GET_RESTAURANTS}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Restaurant> restaurants = [];
        for (var x in response.data['data']) {
          Restaurant restaurant = Restaurant.fromJson(x);
          restaurants.add(restaurant);
        }
        return restaurants;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong. Please try again later.");
    }
  }

  @override
  Future<RestaurantDetails> getRestaurantDetails({required int id}) async {
    try {
      var response = await ApiClient.shared.dio.get(
        '${AppSettings.BASE_URL}${AppSettings.GET_RESTAURANT}$id',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        RestaurantDetails restaurantDetails = RestaurantDetails.fromJson(response.data['data']);
        return restaurantDetails;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong. Please try again later.");
    }
  }

}