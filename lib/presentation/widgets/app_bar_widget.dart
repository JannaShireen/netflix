import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key,required this.title,});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          ),
        ),
        
        Spacer(),
        Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
          ),
          kWidth,

        Container(
          width:40,
          height: 30,
          color: Colors.blue,),
          kWidth,
      ],
    );
  }
}