import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';
import 'package:restaurantapp/entity/models/review.dart';

abstract class RestaurantRepositoryInterface {

  Future<List<Restaurant>> getRestaurantList();
  Future<RestaurantDetails> getRestaurantDetails({required int id});
  Future<bool> addReview({required Review review, required int id});
}