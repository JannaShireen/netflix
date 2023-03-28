import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.accents[index % Colors.accents.length],
        ),
        Align(
          alignment:Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.end,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                //left side
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: (){

                    },
                     icon: const Icon(Icons.volume_off,
                     color: kWhiteColor,
                     size: 30,
                     )),
                  
                ),
            // rights side
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CircleAvatar(
                    radius: 30,
                    
                    backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWWsVTjDaK9xTorMHSm6oxAll80fttPtDPkg&usqp=CAU"),
                
                  ),
                ),
                VideoActionWidget(icon: Icons.emoji_emotions, title:'Lol' ),
                VideoActionWidget(icon: Icons.add, title:'My List' ),
                VideoActionWidget(icon: Icons.share, title:'Share' ),
                VideoActionWidget(icon: Icons.play_arrow, title:'Play' )

              ],
            ),
               ],
               ),
          ),
        ),
      ],
    );

  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Column(
        children: [
          Icon(icon,
          color: Colors.white,
          size: 30,),
          Text(title,
          style: const TextStyle(
            color: kWhiteColor,
            fontSize: 14,
          ),
          ),
          
        ],
      ),
    );
  }
}