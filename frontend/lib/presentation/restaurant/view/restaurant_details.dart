import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_details_cubit.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_details_state.dart';
import 'package:restaurantapp/utils/loader/page_loading_indicator.dart';
import 'package:restaurantapp/utils/router/app_pages.dart';
import 'package:restaurantapp/utils/spacer/spacer.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = Get.arguments as Restaurant;

    return BlocProvider<RestaurantDetailsCubit>(
      create: (BuildContext context) =>
          RestaurantDetailsCubit(RestaurantRepository())
            ..getRestaurant(id: restaurant.id),
      child: BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
        builder: (BuildContext context,
            RestaurantDetailsState restaurantDetailState) {
          switch (restaurantDetailState) {
            case LoadingState _:
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            case LoadedState():
              RestaurantDetails restaurantDetails =
                  restaurantDetailState.restaurantDetails;
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  centerTitle: true,
                  backgroundColor: Colors.red,
                  title: Text(
                    restaurant.name,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                floatingActionButton: MaterialButton(
                  onPressed: () async {
                    final result = await Get.toNamed(AppPages.ADD_REVIEW,
                        arguments: restaurant);
                    if (result == true) {
                      if (!context.mounted) return;
                      context
                          .read<RestaurantDetailsCubit>()
                          .getRestaurant(id: restaurant.id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Review added successfully!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    }
                  },
                  color: Colors.orangeAccent,
                  child: Text(
                    'Add review',
                    style: GoogleFonts.merriweather(color: Colors.white),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _image(restaurantDetails),
                        MySpacer.generalHeight,
                        _title(restaurantDetails),
                        MySpacer.extraHeight,
                        _type(restaurantDetails),
                        MySpacer.extraHeight,
                        _menus(restaurantDetails),
                        MySpacer.extraHeight,
                        _reviews(restaurantDetails)
                      ],
                    ),
                  ),
                ),
              );
            case ErrorState _:
              return Center(
                  child: Text('Error: ${restaurantDetailState.message}'));
            default:
              return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _reviews(RestaurantDetails restaurantDetails) {
    return ExpansionTile(
        title: Text(
          'Reviews',
          style: GoogleFonts.merriweather(
              fontSize: 18, fontWeight: FontWeight.w800),
        ),
        children: restaurantDetails.reviews
            .map((review) => Column(
                  children: [
                    ListTile(
                      title: Text(
                        review.user,
                        style: GoogleFonts.merriweather(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        review.comment,
                        style: GoogleFonts.merriweather(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                    )
                  ],
                ))
            .toList());
  }

  Widget _menus(RestaurantDetails restaurantDetails) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Menu',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.merriweather(
                  fontSize: 18, fontWeight: FontWeight.normal),
            ))
          ],
        ),
        Column(
          children: restaurantDetails.menus
              .map((menu) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          menu.name,
                          style: GoogleFonts.abel(fontSize: 18),
                        ),
                        trailing: Text(
                          '${menu.price} Ft',
                          style: GoogleFonts.almarai(
                              fontSize: 18, color: Colors.red),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      )
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _title(RestaurantDetails restaurantDetails) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              restaurantDetails.name,
              style: GoogleFonts.abel(fontSize: 24),
            )),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                  size: 30,
                ),
                Text(
                  restaurantDetails.avgRating,
                  style: GoogleFonts.abel(fontSize: 14),
                ),
              ],
            )
          ],
        ),
        MySpacer.generalHeight,
        Row(
          children: [
            const Icon(
              CupertinoIcons.location_solid,
              color: Colors.red,
            ),
            Text(
              restaurantDetails.location,
              style: GoogleFonts.abel(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  Widget _image(RestaurantDetails restaurantDetails) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: CachedNetworkImage(
        imageUrl: restaurantDetails.image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const PageLoadingIndicator(),
        errorWidget: (context, url, error) =>
            const SizedBox(width: 80, height: 80, child: Icon(Icons.error)),
      ),
    );
  }

  Widget _type(RestaurantDetails restaurantDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.orange,
          ),
          child: Text(restaurantDetails.type,
              style: GoogleFonts.abel(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
