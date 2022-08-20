// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_item.dart';
import 'package:movies_app/screens/details_screen.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/dimensions.dart';
import 'package:movies_app/widgets/my_text.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';

class GestureBuilder extends StatelessWidget {
  const GestureBuilder({
    Key? key,
    required this.list,
    required this.i,
    required this.isCarousal,
  }) : super(key: key);

  final List<MovieItem> list;
  final bool isCarousal;
  final int i;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String trailerKey = await Provider.of<MovieProvider>(
          context,
          listen: false,
        ).getTrailer(list[i].id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              trailerKey: trailerKey,
              imgUrl: list[i].poster_path,
              overView: list[i].overview,
              title: list[i].original_title,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: Dimensions.width15,
        ),
        height: isCarousal == true ? null : Dimensions.height100 * 1.9,
        width: isCarousal == true ? null : Dimensions.width100 * 1.4,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(
            Dimensions.width15,
          ),
          image: DecorationImage(
            image: NetworkImage(
              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2${list[i].poster_path}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: Dimensions.height35,
                width: Dimensions.width100 * 0.55,
                decoration: BoxDecoration(
                  color: AppColors.secondryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      Dimensions.width15,
                    ),
                    bottomLeft: Radius.circular(
                      Dimensions.width15,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: MyText(
                    text: list[i].vote_average.toString(),
                    size: Dimensions.font15,
                    isBold: true,
                    aling: TextAlign.center,
                  ),
                ),
              ),
            ),
            isCarousal == true
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: Dimensions.width40,
                      width: Dimensions.width100 * 1.5,
                      decoration: BoxDecoration(
                        color: AppColors.secondryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Dimensions.width15,
                          ),
                          topRight: Radius.circular(
                            Dimensions.width15,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.width5 * 1.5,
                          horizontal: Dimensions.width10,
                        ),
                        child: MyText(
                          text: list[i].original_title,
                          size: Dimensions.font15,
                          aling: TextAlign.center,
                          isBold: true,
                          overFLow: true,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
