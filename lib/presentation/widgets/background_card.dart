import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/screen_home.dart';
import 'package:netflix_clone/presentation/widgets/custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
         
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(kMainImage),
              ),
          ),
        ),
        Positioned
        (
          bottom: 0,
          left: 0,
          right: 0,

          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 CustomButtonWidget(
                  title: "My List",
                  icon: Icons.add,
                ), 
                PlayButton(),
                const CustomButtonWidget(icon: Icons.info, title: 'Info')
                          
            ],),
          ),
        )
      ],
    );
  }
}