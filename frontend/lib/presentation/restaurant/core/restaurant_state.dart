import 'package:equatable/equatable.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';

abstract class RestaurantState extends Equatable {}

class InitialState extends RestaurantState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RestaurantState {
  @override
  List<Object> get props => [];
}

class LoadedState extends RestaurantState {
  final List<Restaurant> restaurants;

  LoadedState({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class ErrorState extends RestaurantState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
