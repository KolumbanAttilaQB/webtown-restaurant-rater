import 'package:equatable/equatable.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';

abstract class RestaurantReviewState extends Equatable {}

class InitialState extends RestaurantReviewState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RestaurantReviewState {
  @override
  List<Object> get props => [];
}

class LoadedState extends RestaurantReviewState {
  final bool result;

  LoadedState({required this.result});

  @override
  List<Object> get props => [result];
}

class ErrorState extends RestaurantReviewState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
