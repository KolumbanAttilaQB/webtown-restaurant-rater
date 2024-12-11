class AppSettings {
  /// API
  static const BASE_URL = 'https://restaurants.erdovidekapp.ro/';
  static const GET_RESTAURANTS = 'restaurants';
  static const GET_RESTAURANT = 'restaurant/';

  static String ADD_REVIEW(int id) {
    return 'restaurant/$id/review';
  }
}
