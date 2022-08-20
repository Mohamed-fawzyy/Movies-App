import 'package:flutter/material.dart';

import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/dimensions.dart';
import 'package:movies_app/widgets/my_text.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/home_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<MovieProvider>(context).fetchMovies(1).then(
            (_) => setState(
              () {
                _isLoading = false;
              },
            ),
          );
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  bool _isSearch = false;
  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: MyText(
          text: 'Movies',
          size: Dimensions.font25,
          color: Colors.white,
          isBold: true,
        ),
        elevation: 8,
        shadowColor: const Color.fromARGB(125, 182, 179, 179),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearch = !_isSearch;
                });
              },
            ),
          ),
        ],
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.textColor,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.height15,
                vertical: Dimensions.height25,
              ),
              child: HomeItem(movies: movies, isSearch: _isSearch),
            ),
    );
  }
}
