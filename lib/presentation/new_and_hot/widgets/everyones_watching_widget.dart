import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_info_card.dart';
import 'package:netflix_clone/presentation/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widgets.dart';
import 'package:http/http.dart' as http;

class EveryonesWatchingWidget extends StatelessWidget {
  const EveryonesWatchingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get(Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US&page=1')),
        builder: (context, AsyncSnapshot<http.Response> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Please wait');
          }
          if (snapshot.data == null) {
            return const Text('No data found');
          }
          http.Response response = snapshot.data!;
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            TMDBApiResponseModel tmdbApiResponse =
                TMDBApiResponseModel.fromJson(data);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: tmdbApiResponse.results.length,
                itemBuilder: (BuildContext context, int index) =>
                    EveryonesWatchingInfoCard(
                        movieInfo: tmdbApiResponse.results[index]));
          }

          return Container();
        });
  }
}
