import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
          
        
        
         Container(
          width: 130,
          height: 200,
          
          decoration:  BoxDecoration(
            borderRadius: kRadius10,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage
            ('https://www.imdb.com/title/tt3521164/mediaviewer/rm618728448/?ref_=tt_ov_i'),)
          ),
        ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -30,
          
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: kWhiteColor,
            child: Text("${index + 1}",
            style: TextStyle(
              fontSize: 150,
              color: kBlackColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              decorationColor: Colors.black,
              ),
              ),
              ),
              ),


      ],
    );
  }
}