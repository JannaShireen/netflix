import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:netflix_clone/presentation/widgets/number_card.dart';
import 'package:http/http.dart' as http;

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<MovieInfoModel> movieInfos = [];
    List imageList = [];
    return FutureBuilder(
        future: http.get(Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US&page=1')),
        builder: (context, AsyncSnapshot<http.Response> snapshot) {
          if (!snapshot.hasData) {
            return Text('Please wait');
          }

          if (snapshot.data == null) {
            return Text('No data found');
          }
          http.Response response = snapshot.data!;
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            TMDBApiResponseModel tmdbApiResponse =
                TMDBApiResponseModel.fromJson(data);

            imageList = tmdbApiResponse.results.map((MovieInfoModel movieInfo) {
              if (movieInfo.posterPath == null) {
                return null;
              }
              String imageUrl =
                  'https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768';
              return imageUrl;
            }).toList();
          }
          if (imageList.isEmpty) {
            return ListTile(title: Text('No Movies Found'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainTitle(
                  title: 'Top 10 Tv Shows in India Today',
                ),
              ),
              kHeight,
              LimitedBox(
                maxHeight: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    imageList.length,
                    (index) => NumberCard(
                      index: index,
                      imageUrl: imageList[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
