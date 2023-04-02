import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:http/http.dart' as http;

import '../search/widgets/search_result.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({
    super.key,
    required this.title,
    required this.apiUrl,
  });

  final String title;
  final String apiUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get(Uri.parse(apiUrl)),
        builder: (context, AsyncSnapshot<http.Response> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Please wait');
          }

          if (snapshot.data == null) {
            return const Text('No data found');
          }

          List<MovieInfoModel> movieInfos = [];
          List imageList = [];
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
            return ListTile(title: Text('No $title'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainTitle(
                  title: title,
                ),
              ),
              kHeight,
              LimitedBox(
                maxHeight: 200,
                child: ListView.builder(
                  itemCount: imageList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MainCard(imageUrlFromApi: imageList[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
