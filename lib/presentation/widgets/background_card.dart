import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/home/screen_home.dart';
import 'package:netflix_clone/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class BackgroundCard extends StatefulWidget {
  const BackgroundCard({
    super.key,
  });

  @override
  State<BackgroundCard> createState() => _BackgroundCardState();
}

class _BackgroundCardState extends State<BackgroundCard> {
  @override
  initState() {
    super.initState();
    apicall();

    // Add listeners to this class
  }

  List<MovieInfoModel> movieInfos = [];
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=b2dee3b855c4ea705ff5dda3c0201768'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TMDBApiResponseModel tmdbApiResponse =
          TMDBApiResponseModel.fromJson(data);

      setState(() {
        if (tmdbApiResponse.results.isNotEmpty) {
          MovieInfoModel movieInfo = tmdbApiResponse.results[0];
          imageUrl =
              "https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768";
        }
        //   List<MovieInfoModel> movieInfos = tmdbApiResponse.results;
        //   movieInfos.removeAt(0);
        //   imageList = movieInfos.map((MovieInfoModel movieInfo) {
        //     if (movieInfo.posterPath == null) {
        //       return null;
        //     }

        //     String imageUrl =
        //         'https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768';
        //     return imageUrl;
        //   }).toList();
      });
    }
  }

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl ?? kMainImage),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(
                  title: "My List",
                  icon: Icons.add,
                ),
                PlayButton(),
                const CustomButtonWidget(icon: Icons.info, title: 'Info')
              ],
            ),
          ),
        )
      ],
    );
  }
}
