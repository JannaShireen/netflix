import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:http/http.dart' as http;

import '../search/widgets/search_result.dart';

class MainTitleCard extends StatefulWidget {
  const MainTitleCard({
    super.key,
    required this.title,
    required this.apiUrl,
  });
  final String title;
  final String apiUrl;

  @override
  State<MainTitleCard> createState() => _MainTitleCardState();
}

class _MainTitleCardState extends State<MainTitleCard> {
  @override
  initState() {
    super.initState();
    apicall();
    // Add listeners to this class
  }

  List<MovieInfoModel> movieInfos = [];
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(widget.apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TMDBApiResponseModel tmdbApiResponse =
          TMDBApiResponseModel.fromJson(data);

      setState(() {
        imageList = tmdbApiResponse.results.map((MovieInfoModel movieInfo) {
          if (movieInfo.posterPath == null) {
            return null;
          }

          String imageUrl =
              'https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768';
          return imageUrl;
        }).toList();
      });
    }
  }

  List imageList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainTitle(
            title: widget.title,
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
  }
}
