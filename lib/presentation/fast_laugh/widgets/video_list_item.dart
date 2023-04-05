import 'dart:convert';
import 'package:netflix_clone/infrastructure/api_key.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_info.dart';
import 'package:netflix_clone/models/tmdb_api_response.dart';

final dummyvideUrl = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"
];

class VideoListItem extends StatefulWidget {
  final int index;
  const VideoListItem({required this.index, super.key});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  List imageList = [];
  Future trendingModelApi() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      TMDBApiResponseModel trendingModel = TMDBApiResponseModel.fromJson(data);
      setState(() {
        imageList = trendingModel.results.map((MovieInfoModel result) {
          String imageUrl =
              "https://image.tmdb.org/t/p/w500/${result.posterPath}?api_key=$apiKey";
          return imageUrl;
        }).toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingModelApi();
  }

  @override
  Widget build(BuildContext context) {
    final videoUrl = dummyvideUrl[widget.index % dummyvideUrl.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChaned: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // left side
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_off_outlined),
                    color: kWhiteColor,
                    iconSize: 30,
                  ),
                ),

                // right side
                if (imageList.isNotEmpty) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(imageList[widget.index]),
                        ),
                      ),
                      const VideoActionsWidget(
                        icon: Icons.emoji_emotions,
                        title: "LOL",
                      ),
                      const VideoActionsWidget(
                        icon: Icons.add,
                        title: "MyList",
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const VideoActionsWidget(
                          icon: Icons.share,
                          title: "Share",
                        ),
                      ),
                      const VideoActionsWidget(
                        icon: Icons.play_arrow,
                        title: "Play",
                      ),
                    ],
                  )
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChaned;
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChaned});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.network(widget.videoUrl);

  @override
  void initState() {
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _videoPlayerController.pause();
                    });
                  },
                  child: VideoPlayer(_videoPlayerController)))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
