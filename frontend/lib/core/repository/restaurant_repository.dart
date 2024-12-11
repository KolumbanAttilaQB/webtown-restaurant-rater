import 'package:restaurantapp/core/datasource/restaurant_datasource.dart';
import 'package:restaurantapp/core/interface/restaurant_repository_interface.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';

class RestaurantRepository extends RestaurantRepositoryInterface {

  final dataSource = RestaurantDataSource();
  @override
  Future<List<Restaurant>> getRestaurantList() async {
    try {
      final result = await dataSource.getRestaurantList();
      return result;
    } catch (e) {
      throw Exception("Oops! Something went wrong. Please try again later.");
    }
  }
}
