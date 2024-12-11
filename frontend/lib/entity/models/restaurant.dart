class Restaurant {
  final int id;
  final String name;
  final String type;
  final String image;
  final String location;
  final String avgRating;
  final int ratingCount;

  Restaurant({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.location,
    required this.avgRating,
    required this.ratingCount,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      type: json['type'],
      image: json['image'],
      location: json['location'],
      avgRating: json['avg_rating'],
      ratingCount: int.parse(json['rating_count'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': image,
      'location': location,
      'avg_rating': avgRating,
      'rating_count': ratingCount,
    };
  }
}
