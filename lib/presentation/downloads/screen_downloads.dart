import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
   ScreenDownloads({super.key});
   final _widgetList = [ const _SmartDownloads(),
          Section2(),
          const Section3(),
          ];


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(title: "Downloads",),
 ),
      body:ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx,index)=> _widgetList[index], 
        separatorBuilder: (ctx,index)=> SizedBox(height: 25,), 
        itemCount: _widgetList.length)
      
      
      );
  }
}

class Section2 extends StatelessWidget {
   Section2({super.key});
    final List imageList = [
    
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWWsVTjDaK9xTorMHSm6oxAll80fttPtDPkg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0mGQL-BQZGo-UkHtQEOWwuFQyIop4pAmksA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROtkr4fktI2OeLohGfxaUcJb2T5k_AwltLgg&usqp=CAU",

  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
            "Introducing Downloads for you",
            textAlign: TextAlign.center,
            style: TextStyle(
            color: kWhiteColor, fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          kHeight,
          const Text("We will download a personalized selection of \nmovies and shows for you, so there's\n always something to watch on your\n device.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey,
          fontSize: 16,),
          ),
          kHeight,
          
          SizedBox(
            width: size.width,
            height: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  radius: size.width * 0.4,
                ),

                DownloadsImageWidget(
                  imageList: imageList[0],
                  margin: EdgeInsets.only(left: 170, top: 50,),
                  angle: 25,
                  size: Size(size.width * 0.35 , size.width * 0.55),
                  ),
                  
                DownloadsImageWidget(
                  imageList: imageList[1],
                  margin: EdgeInsets.only(right: 170, top: 50),
                  angle: -20,
                  size: Size(size.width * 0.35 , size.width * 0.55),
                  ),
                  
                DownloadsImageWidget(
                  imageList: imageList[2],
                  radius: 8,
                  margin: EdgeInsets.only(bottom: 35, top: 50),
                  size: Size(size.width * 0.4 , size.width * 0.6),
                  ),
              ],
            ),
          ),

      ],
    );
  }
}
class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(
          width: double.infinity,
           child: MaterialButton(
              color: kButtonColorBlue,
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
         
            child: const Padding(
              padding:  EdgeInsets.symmetric(vertical: 10),
              
              child:  Text("Set up",
              style: TextStyle(color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
            ),),
         ),
         kHeight,

          MaterialButton(
            color: kButtonColorWhite,
            onPressed: (){

          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),),
          child:const  Padding(
            padding:  EdgeInsets.symmetric(vertical: 10),
            child:  Text("See what you can download",
            style: TextStyle(
              color: kBlackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            ),
          ),),

      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.settings,
      color: kWhiteColor,
      ),
      kWidth,
      Text("Smart Downloads")

    ],);
  }
}

class DownloadsImageWidget extends StatelessWidget {
   DownloadsImageWidget({
    super.key,
    
    required this.imageList,
     this.angle=0,
     required this.size,
     required this.margin,
     this.radius=10,
  });
  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi /180,
                
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
           
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                fit: BoxFit.cover,
              image: NetworkImage(imageList),
              ),
              ),
          ),
        ),
      ),
    );
  }
}