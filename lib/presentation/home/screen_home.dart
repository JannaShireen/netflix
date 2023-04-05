import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/background_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';
import 'package:netflix_clone/presentation/widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (BuildContext context, index, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: ((notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value == false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                }),
                child: Stack(
                  children: [
                    ListView(
                      children: const [
                        BackgroundCard(),
                        MainTitleCard(
                            title: "New Releases",
                            apiUrl:
                                "https://api.themoviedb.org/3/movie/latest?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US"),
                        kHeight,
                        MainTitleCard(
                          title: "Trending Now",
                          apiUrl:
                              'https://api.themoviedb.org/3/trending/all/day?api_key=b2dee3b855c4ea705ff5dda3c0201768',
                        ),
                        kHeight,
                        NumberTitleCard(),
                        kHeight,
                        MainTitleCard(
                            title: "Popular",
                            apiUrl:
                                'https://api.themoviedb.org/3/tv/popular?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US&page=1'),
                        kHeight,
                        MainTitleCard(
                            title: "Upcoming",
                            apiUrl:
                                'https://api.themoviedb.org/3/movie/upcoming?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US&page=1'),
                        kHeight,
                      ],
                    ),
                    scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 90,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://images.crowdspring.com/blog/wp-content/uploads/2016/06/27132348/netflix-new-logo.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    kWidth,
                                    Container(
                                      width: 30,
                                      height: 30,
                                      color: Colors.blue,
                                    ),
                                    kWidth,
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("TV Shows", style: kHomeTitleText),
                                    Text(
                                      "Movies",
                                      style: kHomeTitleText,
                                    ),
                                    Text(
                                      "Categories",
                                      style: kHomeTitleText,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : kHeight,
                  ],
                ),
              );
            }));
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kWhiteColor),
        ),
        icon: const Icon(
          Icons.play_arrow,
          size: 25,
          color: kBlackColor,
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Play",
            style: TextStyle(
              fontSize: 20,
              color: kBlackColor,
            ),
          ),
        ));
  }
}
