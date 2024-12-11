import 'package:get/get.dart';
import 'package:restaurantapp/presentation/home/view/homescreen.dart';
import 'package:restaurantapp/presentation/restaurant/view/restaurant_details.dart';
part 'app_routes.dart';

class AppPages {
  static var HOME = Routes.HOME;
  static var RESTAURANT_DETAILS = Routes.RESTAURANT_DETAILS;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.RESTAURANT_DETAILS,
      page: () => const RestaurantDetailsScreen(),
    ),
  ];
}
