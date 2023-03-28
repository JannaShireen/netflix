import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';

const imageUrl = 
    "https://cdnb.artstation.com/p/assets/images/images/026/475/643/large/spencer-owen-i-am-lisa-landscape.jpg?1588873984";


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
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const TopSearchItemTile(), 
            separatorBuilder: ((context, index) =>kHeight20 ),
             itemCount: 10),
        )
      ],
    );
  }
}


class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(children: [
      Container(
        width: screenWidth*0.35,
        height: 65,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl))
        ),
      ),
      kWidth,
      Expanded(child: Text('Movie Name',style: TextStyle(
        color: kWhiteColor, fontWeight: FontWeight.bold,
        fontSize: 16,
      ),),),

      CircleAvatar(
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
      )
    ],);
}
}
