import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/entity/models/review.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_review_state.dart';

class RestaurantReviewCubit extends Cubit<RestaurantReviewState> {
  RestaurantReviewCubit(this.repository) : super(InitialState());
  RestaurantRepository repository;

  Future<void> addReview({required Review review,required int id}) async {
    emit(LoadingState());
    try {
      final result = await repository.addReview(id: id, review: review);
      emit(LoadedState(result: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
