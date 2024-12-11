import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_cubit.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_state.dart';
import 'package:restaurantapp/presentation/restaurant/view/widgets/restaurant_card.dart';
import 'package:restaurantapp/utils/spacer/spacer.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantCubit>(
      create: (BuildContext context) =>
          RestaurantCubit(RestaurantRepository())..loadRestaurants(),
      child: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (BuildContext context, RestaurantState restaurantState) {
          switch (restaurantState) {
            case LoadingState _:
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            case LoadedState():
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        if(!context.mounted) return;
                        context.read<RestaurantCubit>().searchRestaurant(query: value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search'
                      ),
                    ),
                    MySpacer.extraHeight,
                    if(restaurantState.restaurants.isNotEmpty)
                    Column(
                      children: restaurantState.restaurants
                          .map((restaurant) => restaurantCard(
                              context: context, restaurant: restaurant))
                          .toList(),
                    )
                    else
                      const Center(child: Text('No restaurants'))
                  ],
                ),
              );
            case ErrorState _:
              return Center(child: Text('Error: ${restaurantState.message}'));
            default:
              return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
