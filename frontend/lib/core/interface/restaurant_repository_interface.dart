import 'package:restaurantapp/entity/models/restaurant.dart';

abstract class RestaurantRepositoryInterface {

  Future<List<Restaurant>> getRestaurantList();
}