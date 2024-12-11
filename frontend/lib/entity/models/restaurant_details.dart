import 'package:restaurantapp/entity/models/menu.dart';
import 'package:restaurantapp/entity/models/review.dart';

class RestaurantDetails {
  final int id;
  final String name;
  final String type;
  final String image;
  final String location;
  final String avgRating;
  final int ratingCount;
  final List<Menu> menus;
  final List<Review> reviews;

  RestaurantDetails({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.location,
    required this.avgRating,
    required this.ratingCount,
    required this.menus,
    required this.reviews,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) {
    return RestaurantDetails(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      image: json['image'],
      location: json['location'],
      avgRating: json['avg_rating'],
      ratingCount: json['rating_count'],
      menus: (json['menus'] as List).map((menu) => Menu.fromJson(menu)).toList(),
      reviews:
      (json['reviews'] as List).map((review) => Review.fromJson(review)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type': type,
      'location': location,
      'avg_rating': avgRating,
      'rating_count': ratingCount,
      'menus': menus.map((menu) => menu.toJson()).toList(),
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
