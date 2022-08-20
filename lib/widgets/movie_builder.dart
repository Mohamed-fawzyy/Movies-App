// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_item.dart';

import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/dimensions.dart';
import 'package:movies_app/widgets/my_text.dart';

import '../providers/movie_provider.dart';
import 'gesture_builder.dart';

class MovieBuilder extends StatelessWidget {
  const MovieBuilder({
    Key? key,
    required this.movies,
    required this.list,
    this.isCarousal = false,
  }) : super(key: key);

  final MovieProvider movies;
  final bool? isCarousal;
  final List<MovieItem> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height100 * 2.3,
      child: isCarousal == true ? carouselMovie() : normalMovies(),
    );
  }

  CarouselSlider carouselMovie() {
    return CarouselSlider.builder(
      itemCount: movies.topRatedMovieLength,
      itemBuilder: (context, i, realIndex) => GestureBuilder(
        list: list,
        i: i,
        isCarousal: true,
      ),
      options: CarouselOptions(
        height: Dimensions.movieView,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
    );
  }

  ListView normalMovies() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureBuilder(list: list, i: i, isCarousal: false),
          SizedBox(height: Dimensions.height5),
          SizedBox(
            width: Dimensions.width100 * 1.4,
            child: MyText(
              text: list[i].original_title,
              overFLow: true,
              size: Dimensions.font18,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
