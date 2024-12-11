import 'package:get/get.dart';
import 'package:restaurantapp/presentation/home/view/homescreen.dart';
part 'app_routes.dart';

class AppPages {
  static var HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      children: const [],
    ),
  ];
}
