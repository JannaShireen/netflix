
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:netflix_clone/presentation/widgets/number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final apiUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=b2dee3b855c4ea705ff5dda3c0201768&language=en-US&page=1";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child:   MainTitle(title: 'Top 10 Tv Shows in India Today',),
       ),
        kHeight,
        LimitedBox(
    maxHeight: 200,
    
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
      10, (index) =>  NumberCard(index: index,),
      ),
    ),
    ),
      ],
    );
  }
}