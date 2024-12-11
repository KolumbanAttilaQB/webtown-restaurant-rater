import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';

abstract class RestaurantDatasourceInterface {

  Future<List<Restaurant>> getRestaurantList();
  Future<RestaurantDetails> getRestaurantDetails({required int id});
}