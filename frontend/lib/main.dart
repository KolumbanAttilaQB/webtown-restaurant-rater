import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurantapp/utils/bloc/bloc_observer.dart';
import 'package:restaurantapp/utils/router/app_pages.dart';
import 'package:restaurantapp/utils/theme/app_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

main() async {
  // set bloc observer
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: navigatorKey,
      theme: AppTheme().getTheme(), // load app theme
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: AppPages.HOME,
      getPages: AppPages.routes,
    );
  }
}