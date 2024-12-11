import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';

Widget restaurantCard({required BuildContext context, required Restaurant restaurant}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CachedNetworkImage(
                imageUrl: restaurant.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        ),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}