import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantapp/core/repository/restaurant_repository.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';
import 'package:restaurantapp/entity/models/review.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_review_cubit.dart';
import 'package:restaurantapp/presentation/restaurant/core/restaurant_review_state.dart';
import 'package:restaurantapp/utils/loader/page_loading_indicator.dart';
import 'package:restaurantapp/utils/spacer/spacer.dart';

class AddReviewScreen extends StatelessWidget {
  AddReviewScreen({super.key});

  double value = 3.5;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController user = TextEditingController();
  final TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = Get.arguments as Restaurant;

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
        title: const Text(
          'Add review',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: BlocProvider<RestaurantReviewCubit>(
            create: (BuildContext context) =>
                RestaurantReviewCubit(RestaurantRepository()),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MySpacer.extraHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return RatingStars(
                            value: value,
                            onValueChanged: (v) {
                              setState(() {
                                value = v;
                              });
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 40,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: false,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          );
                        },
                      ),
                    ],
                  ),
                  
                  MySpacer.extraHeight,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: user,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        MySpacer.generalHeight,
                        TextFormField(
                          controller: comment,
                          decoration: const InputDecoration(
                            hintText: 'Enter your comment here...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 10,
                          minLines: 3,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Comment cannot be empty';
                            }
                            return null;
                          },
                        ),
                        MySpacer.extraHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<RestaurantReviewCubit,
                                RestaurantReviewState>(
                              builder: (BuildContext context,
                                  RestaurantReviewState state) {
                                if (state is ErrorState) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Oops! Something went wrong. Please try again later.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                if (state is LoadedState) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Get.back();
                                  });
                                }

                                return MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context
                                          .read<RestaurantReviewCubit>()
                                          .addReview(
                                              review: Review(
                                                  user: user.text,
                                                  comment: comment.text,
                                                  rating: int.parse(value
                                                      .toStringAsFixed(0))),
                                              id: restaurant.id);
                                    }
                                  },
                                  color: Colors.orange,
                                  child: state is LoadingState
                                      ? const PageLoadingIndicator(color: Colors.white,)
                                      : Text(
                                          'SEND',
                                          style: GoogleFonts.merriweather(
                                              color: Colors.white),
                                        ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
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
