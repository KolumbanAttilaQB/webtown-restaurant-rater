import 'package:flutter/material.dart';
import 'package:restaurantapp/presentation/restaurant/view/restaurant_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text('RR APP', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: const RestaurantScreen(),
      ),
    );
  }
}
