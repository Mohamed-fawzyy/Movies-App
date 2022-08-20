import 'package:flutter/material.dart';

import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/dimensions.dart';
import 'package:movies_app/widgets/my_text.dart';

import '../providers/movie_provider.dart';
import '../widgets/movie_builder.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    required this.movies,
    required this.isSearch,
  }) : super(key: key);

  final MovieProvider movies;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSearch == true
              ? SizedBox(
                  height: Dimensions.height50,
                  width: double.infinity,
                  child: TextFormField(
                    cursorColor: AppColors.textColor,
                    style: const TextStyle(color: AppColors.textColor),
                    decoration: const InputDecoration(
                      hintText: 'Search for movie',
                      hintStyle: TextStyle(color: AppColors.textColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(187, 151, 150, 150),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(187, 151, 150, 150),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textColor,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      movies.searchMovies(value, context);
                    },
                  ),
                )
              : const SizedBox(),
          SizedBox(height: Dimensions.height15),
          MyText(
            text: 'Top Rated',
            size: Dimensions.font20,
            isBold: true,
            color: Colors.white,
          ),
          SizedBox(height: Dimensions.height20),
          MovieBuilder(
            movies: movies,
            isCarousal: true,
            list: movies.topRatedMovie,
          ),
          SizedBox(height: Dimensions.height20),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Trending',
                  isBold: true,
                  size: Dimensions.font20,
                  color: AppColors.textColor,
                ),
                SizedBox(height: Dimensions.height15),
                MovieBuilder(
                  movies: movies,
                  list: movies.trendMovie,
                ),
                SizedBox(height: Dimensions.height20),
                MyText(
                  text: 'New & Popular',
                  isBold: true,
                  size: Dimensions.font20,
                  color: AppColors.textColor,
                ),
                SizedBox(height: Dimensions.height15),
                MovieBuilder(
                  movies: movies,
                  list: movies.popularMovie,
                ),
                SizedBox(height: Dimensions.height25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
