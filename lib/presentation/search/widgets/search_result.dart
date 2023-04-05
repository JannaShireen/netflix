import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';
import 'package:http/http.dart' as http;

const imageUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWWsVTjDaK9xTorMHSm6oxAll80fttPtDPkg&usqp=CAU";

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.apiQuery});
  final String apiQuery;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Movies & TV'),
        kHeight,
        Expanded(
          child: FutureBuilder(
              future: http.get(Uri.parse(
                  'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$apiQuery')),
              builder: (context, AsyncSnapshot<http.Response> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Please wait');
                }

                if (snapshot.data == null) {
                  return const Text('No data found');
                }
                List imageList = [];
                http.Response response = snapshot.data!;
                if (response.statusCode == 200) {
                  Map<String, dynamic> data = jsonDecode(response.body);
                  TMDBApiResponseModel tmdbApiResponse =
                      TMDBApiResponseModel.fromJson(data);

                  imageList =
                      tmdbApiResponse.results.map((MovieInfoModel movieInfo) {
                    if (movieInfo.posterPath == null) {
                      return null;
                    }

                    String imageUrl =
                        'https://image.tmdb.org/t/p/w500${movieInfo.posterPath}?api_key=b2dee3b855c4ea705ff5dda3c0201768';
                    return imageUrl;
                  }).toList();

                  if (imageList.isEmpty) {
                    return ListTile(title: Text('NO Movies Found'));
                  }
                }

                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1 / 1.4,
                  children: List.generate(
                    imageList.length,
                    (index) {
                      return MainCard(imageUrlFromApi: imageList[index]);
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrlFromApi;
  const MainCard({super.key, required this.imageUrlFromApi});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(imageUrlFromApi), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
