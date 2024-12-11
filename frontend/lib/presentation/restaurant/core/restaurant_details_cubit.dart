import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_details_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantDetailsCubit(this.repository) : super(InitialState());
  RestaurantRepository repository;

  Future<void> getRestaurant({required int id}) async {
    emit(LoadingState());
    try {
      final restaurant = await repository.getRestaurantDetails(id: id);
      emit(LoadedState(restaurantDetails: restaurant));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
