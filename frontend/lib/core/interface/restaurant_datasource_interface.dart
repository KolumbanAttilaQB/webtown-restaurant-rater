import 'package:restaurantapp/entity/models/restaurant.dart';

abstract class RestaurantDatasourceInterface {

  Future<List<Restaurant>> getRestaurantList();
}