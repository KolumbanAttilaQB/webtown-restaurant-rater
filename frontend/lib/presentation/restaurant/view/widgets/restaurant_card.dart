import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/utils/loader/page_loading_indicator.dart';
import 'package:restaurantapp/utils/router/app_pages.dart';

Widget restaurantCard(
    {required BuildContext context, required Restaurant restaurant}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppPages.RESTAURANT_DETAILS, arguments: restaurant);
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.white,
          elevation: 10,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: restaurant.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const PageLoadingIndicator(),
                      errorWidget: (context, url, error) =>
                          const SizedBox(width: 80, height: 80,child: Icon(Icons.error)),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellowAccent,
                            ),
                            Text(
                              restaurant.avgRating.toString(),
                              style: GoogleFonts.abel(color: Colors.white),
                            )
                          ],
                        ),
                      ))
                ],
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          restaurant.name,
                          style:
                              GoogleFonts.abel(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.location_solid, size: 20, color: Colors.white,),
                          Text(
                            restaurant.location,
                            style:
                            GoogleFonts.abel(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
