import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit(this.repository) : super(InitialState());
  RestaurantRepository repository;

  Future<void> getRestaurants() async {
    emit(LoadingState());
    try {
      final restaurants = await repository.getRestaurantList();
      emit(LoadedState(restaurants: restaurants));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
