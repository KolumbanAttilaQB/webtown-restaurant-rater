import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit(this.repository) : super(InitialState());
  final RestaurantRepository repository;
  List<Restaurant> _originalList = [];


  Future<void> loadRestaurants() async {
    emit(LoadingState());
    try {
      _originalList = await repository.getRestaurantList();
      emit(LoadedState(restaurants: _originalList));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> searchRestaurant({required String query}) async {
    if (query.isEmpty) {
      emit(LoadedState(restaurants: _originalList));
    } else {
      emit(LoadingState());
      try {
        final filteredRestaurants = _originalList.where((restaurant) {
          final nameMatch =
          removeDiacritics(restaurant.name.toLowerCase()).contains(query.toLowerCase());
          final locationMatch =
          removeDiacritics(restaurant.location.toLowerCase()).contains(query.toLowerCase());
          return nameMatch || locationMatch;
        }).toList();

        emit(LoadedState(restaurants: filteredRestaurants));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    }
  }
}
