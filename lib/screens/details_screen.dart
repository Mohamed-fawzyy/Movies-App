import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:movies_app/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/dimensions.dart';
import '../widgets/my_text.dart';

class DetailsScreen extends StatefulWidget {
  final String trailerKey;
  final String imgUrl;
  final String title;
  final String overView;

  const DetailsScreen({
    Key? key,
    required this.trailerKey,
    required this.imgUrl,
    required this.title,
    required this.overView,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  YoutubePlayerController? utubeController;
  @override
  void initState() {
    utubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=${widget.trailerKey}')!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        loop: false,
        mute: false,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    utubeController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    utubeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: MyText(
          text: 'Movies',
          size: Dimensions.font25,
          color: Colors.white,
          isBold: true,
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://www.themoviedb.org/t/p/w600_and_h900_bestv2${widget.imgUrl}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              color: AppColors.mainColor.withOpacity(0.4),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Dimensions.height15),
              Container(
                height: Dimensions.movieView * 1.41,
                width: double.infinity,
                margin: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.secondryColor,
                  borderRadius: BorderRadius.circular(Dimensions.height25),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  child: Column(
                    children: [
                      MyText(
                        text: 'Trailer',
                        size: Dimensions.font20,
                        isBold: true,
                        color: AppColors.textColor,
                        aling: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.width15),
                        child: YoutubePlayer(
                          controller: utubeController!,
                          onReady: () {
                            utubeController!.play();
                          },
                        ),
                      ),
                      MyText(
                        text: widget.title,
                        size: Dimensions.font20,
                        isBold: true,
                        color: AppColors.textColor,
                        aling: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.width15),
                child: MyText(
                  text: widget.overView,
                  isItalic: true,
                  size: Dimensions.font20,
                  isBold: true,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchUrl(Uri.parse(
              'https://best.egybest.film:2053/find/?q=${widget.title}'));
        },
        label: const Text('Search EgyBest'),
        backgroundColor: AppColors.secondryColor,
      ),
    );
  }
}
