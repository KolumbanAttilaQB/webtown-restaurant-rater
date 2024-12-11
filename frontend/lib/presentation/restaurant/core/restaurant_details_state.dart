import 'package:equatable/equatable.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';

abstract class RestaurantDetailsState extends Equatable {}

class InitialState extends RestaurantDetailsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RestaurantDetailsState {
  @override
  List<Object> get props => [];
}

class LoadedState extends RestaurantDetailsState {
  final RestaurantDetails restaurantDetails;

  LoadedState({required this.restaurantDetails});

  @override
  List<Object> get props => [restaurantDetails];
}

class ErrorState extends RestaurantDetailsState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
