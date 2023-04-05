import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';
import 'package:http/http.dart' as http;

//const imageUrl =
//"https://cdnb.artstation.com/p/assets/images/images/026/475/643/large/spencer-owen-i-am-lisa-landscape.jpg?1588873984";

class SearchIdleWidget extends StatelessWidget {
  SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: FutureBuilder(
              future: http.get(Uri.parse(
                  'https://api.themoviedb.org/3/trending/all/day?api_key=b2dee3b855c4ea705ff5dda3c0201768')),
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
                  return ListView.separated(
                      itemCount: tmdbApiResponse.results.length,
                      separatorBuilder: ((context, index) => kHeight20),
                      itemBuilder: (BuildContext context, int index) =>
                          TopSearchItemTile(
                              movieInfo: tmdbApiResponse.results[index]));
                } else {
                  return const Center(
                    child: Text('Sorry, something went wrong'),
                  );
                }
              }),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile({
    super.key,
    required this.movieInfo,
  });
  final MovieInfoModel movieInfo;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String url =
        'https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768';
    return ListTile(
        leading: Container(
          width: screenWidth * 0.17,
          height: 65,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(url))),
        ),
        title: Text(
          movieInfo.title ?? 'No Movie Name Found',
          style: const TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 23,
            child: Center(
              child: Icon(
                CupertinoIcons.play_fill,
                color: kWhiteColor,
              ),
            ),
          ),
        ));
  }
}
